#include "csoundhandler.h"
#include <QFile>
#include <QDebug>
#include <QTemporaryFile>
#include <QProcess>
#include <QDir>

CsoundHandler::CsoundHandler(QObject *parent) : QObject(parent)
{

}

CsoundHandler::~CsoundHandler()
{
	system("killall csound");
}

void CsoundHandler::start(QString scoFileName, int fromBar)
{
	// load scoreFile
	QFile scoreFile(scoFileName);

	if (scoreFile.open(QFile::ReadOnly  |QFile::Text)) {
		QString contents = QString(scoreFile.readAll());
		QStringList lines = contents.split("\n");
		QStringList tempoLines;
		float startTime = 0;
		foreach (QString line, lines) {
			line = line.simplified();
			if (line.startsWith("i 1 ") || line.startsWith("i1 ") ) {
				qDebug()<<"tempo line: "<<line;
				tempoLines.append(line);
			}
			if (line.startsWith("i 2") || line.startsWith("i2") ) {
				QStringList fields = line.split(" ");
				int barno = fields[7].toInt();
				if (barno==fromBar) {
					qDebug()<<"Found bar "<<barno;
					startTime = fields[2].toFloat();
					qDebug()<<"Starts at: " << startTime;

				}
			}

		}

		if (fromBar>1) {
			QString tempo = "#TEMPO1#";
			QString replaceString = "a 0 0 "+ QString::number(startTime - 0.01) + "\n";

			// find what was the last temo setting (i 1 statement) before startTime and reinsert it
			for (int i=tempoLines.length()-1; i>=0;i--) { // from end towards beginning
				QStringList fields = tempoLines[i].split(" ");
				if (fields[2].toFloat() <= startTime) {
					fields[2] = QString::number(startTime); // replace the time that is jumped over with the time where the bar starts
					tempo = fields[4] ;
					QString newTempoLine = fields.join(" ") + "\n\n";
					replaceString += newTempoLine;
					break; // no momre searching needed
				}
			}
			qDebug()<<"replaceString: "<<replaceString;
			contents.replace(";ADVANCE",replaceString);
			contents.replace( "#define REPTEMPO #$TEMPO1#", "#define REPTEMPO #" + tempo + "#"); // tempo of count-down
		}

		//QTemporaryFile tempFile(QDir::tempPath()+"/XXXXXX.sco");
		QFile tempFile("temp.sco");
		if (tempFile.open(QFile::WriteOnly  |QFile::Text) ) {
			tempFile.write(contents.toLocal8Bit().data());
			qDebug()<<"TEmp file: "<<tempFile.fileName();
			tempFile.close();

			QString command = "csound -d -g -odac -+rtaudio=jack /home/tarmo/tarmo/csound/metronome/metro_blank.orc "+ tempFile.fileName() + " &";
			system(command.toLocal8Bit());
		}

	}





}

void CsoundHandler::stop()
{
	// Process csound  - kill, stop vms
	system("killall csound");
}

