# D&D Aux: Descent into avernus

Hier sammeln wir die Recaps unserer Abenteuer in Baldur's Gate, Avernus und auf
dem jeweiligen Weg dort hin.

# Beiträge erstellen

Neue Beiträge werden in Markdown unter `_posts` erstellt, der Dateiname folgt
dem Schema:

`2020-04-11_aufbruch_aus_waterdeep.md`, wobei als Datum das der jeweiligen Session
genommen wird.

## Weitere Metadaten

* `layout`: für gewöhnlich `post`.
* `title`: Die Überschrift. Der Dateiname sollte ein *slug* zur Überschrift sein.
* `excerpt`: Kurze Zusammenfassung, die in der Beitragsübersicht zu sehen ist.
* `background`: Titelbild zum Artikel
* `dr_date`: [Das Datum nach *Dale Reckoning*](https://en.wikipedia.org/wiki/Calendars_in_the_Forgotten_Realms), z.B. *7. Kytorn 1494*.

## Tags

Nebst der normalen Formattierung mit [Github flavoured
Markdown](https://github.github.com/gfm/) gibt es noch einige *Tags*, die wie
Macros automatisch Code für Infoboxen o.Ä. generieren.

* `{% include glossary_link.html name="Grafton" title="den Zwerg"%}` erstellt
  einen Verweis zum Glossar. Dabei muss `name` der Name des Artikels im Glossar
  sein. Wir im Fließtext eine Flektion davon gebraucht oder soll der Text einfach
  anders dort auftauchen, kann man mit `title` den gewünschten Linktext angeben,
  ansonsten wird der Name des Artikels genommen.
* Infoboxen: Um im Fließtext kleine Boxen zu erstellen, die wichtige Informationen
  wie erteilte Quests herausstellen, gibt's Infoboxen, deren HTML-Code etwa so
  aussehen sollte, damit das bestehende CSS sie richtig formattiert:

```html
<div class="infobox quest">
  <h3>Das Buch finden</h3>
  <p>Wir wollen das gestohlene Buch wiederfinden.</p>
  <p class="reward">Ruhm und Ehre</p>
</div>
```

Bislang gibt es die Klassen `quest` und `hint`. Einen Absatz mit `reward`
hinzuzufügen ist dabei natürlich optional.

## Hilfsmittel

Damit man nicht mühsam alle Glossar-Einträge selbst vornehmen muss, gibt es ein
Script, was man über den *Markdown*-Code laufen lassen kann. Das schleift dabei
nur über alle Worte und versucht, sie mit bestehenden Glossar-Einträgen zu
verknüpfen. Man kann es auch mehrmals laufen lassen - was bereits ein Glossar-Link
ist, wird nicht nochmal verschachtelt verlinkt. Weitere Logik gibt es dahinter
aber nicht - hat man ein Wort gebeugt oder anders formuliert und hätte es trotzdem
gerne zum Glossar verlinkt, muss man das von Hand machen.

```shell
$ git add _posts/2020-04-11_aufbruch_aus_waterdeep
$ ./glossary_preproc.rb _posts/2020-04-11_aufbruch_aus_waterdeep.md
$ git diff
```

Es empfiehlt sich, dabei die oben beschriebene Reihenfolge einzuhalten. Das Script
ändert die Markdown-Datei *in place*. Um kontrollieren zu können, ob dabei etwas
schief gegangen ist, kann man den fertig geschriebenen Artikel schon mal in den
Index schieben und danach den Unterschied zeigen lassen, bevor man auch diesen
zum Index hinzufügt und den Commit macht.

## Spezialsektionen

### Charaktere

Um einen Eintrag für einen Charakter anzulegen wird gebraucht:

* Token-Bild, `128x128` Pixel unter `img/portraits/$charname.png`
* Großes Hintergrundbild, z.B. `2610x1316` - Seitenverhältnis muss stimmen - unter `img/portraits/$charname_bg.jpg`. Hier kann der Dateiname, insbesondere die Endung, auch abweichen, weil der URI ausdrücklich in der Markdown-Datei gesetzt wird
* Charakterbeschreibung in `_characters/$charname.md`

Für das große Hintergrundbild gibt es kein Patentrezept, weil sich die Bilder
dafür zu sehr voneinander unterscheiden. Ein Lösungsvorschlag ist, *irgendein*
großes Bild des Charakters auf die *Höhe* des Bildes zu skalieren und die
leeren Flächen mit weichgezeichnetem Hintergrund auszufüllen. Dazu kann man das
*ganze* Originalbild nochmal als eigene Ebene im Hintergrund einfügen,
proportional so skalieren, dass auch die Brete ausgefüllt wird, dann mit der
ersten Ebene vereinen, die dann einzige Ebene nochmal duplizieren, zuoberst auf
den Stapel legen, stark weichzeichnen und dann eine Ebenenmaske anlegen. Mit
Hilfe der Ebenenmaske kann man dann einen etwas weichen Übergang des scharfen
Chars in der Mitte und des weichen Hintergrunds drum herum herstellen.

Charaktere werden in ihren `_characters/$charname.md` beschrieben. Dort können
auch einige Metadaten gesetzt werden, im *YAML Front matter*:

```yaml
---
title: Grafton
race: Zwerg
player: Florian
player_link: https://twitter.com/heinlef
layout: character
background: /img/portraits/grafton_bg.jpg
---
```

Notwendige Attribute sind `title` und `layout`, alles weitere ist optional.

**Hinweis**:: `jekyll` ermittelt bei Änderungen innerhalb einer `collection` wie
den Characteren nicht automatische alle notwendigen Neu-Generierungen. Wenn sich
die `/characters/`-Seite nach einer Änderung an einem `/_characters/$charname.md`
nicht aktualisiert, muss `_site/characters/index.html` gelöscht werden, um das
erneute Generieren der Seite zu erzwingen.

## Development

* Install rbenv + ruby 2.6.6
* Run `bundle`
* Open a terminal and run
  * `make serve` or `bundle exec jekyll server --watch --livereload`
* Open the local version in your Browser: http://127.0.0.1:4000/
* Whenever you make a content change, it will automatically be built, served locally and reload your
  tab.
* Please note that you must restart the server when making changes to "_config.yml" (i.e. when
  adding a new icon).
