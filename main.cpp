#include <QTranslator>
#include <QDir>
#include <QStringList>


static const char* language = QT_TRANSLATE_NOOP("@default", "Language");
static const char* greeting = QT_TRANSLATE_NOOP("@default", "greeting"); // not in ts files now!


int main(int argc, char *argv[])
{
  qDebug("Demo");
  QStringList qms = QDir("./").entryList({"*.qm"});
  for (const auto& qm: qms) {
    qDebug("%s: %lld bytes", qPrintable(qm), QFileInfo("./" + qm).size());
    QTranslator appTranslator;
    if (appTranslator.load(qm, "./")) {
      qDebug("  Language: '%s'", qPrintable(appTranslator.translate("@default", language)));
      qDebug("  greeting: '%s'", qPrintable(appTranslator.translate("@default", greeting)));
    } else {
    	qWarning("Failed to load %s", qPrintable(qm));
    }
  }

  return 0;
}
