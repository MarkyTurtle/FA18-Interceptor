# The 3D models and scenery, drawn

These pictures were made by running the game's own drawing code. `tools/models/` loads the
assembled executable into a 68000 emulator ([unicorn](https://www.unicorn-engine.org/)), sets up
an object and a camera, and calls the game's draw routine for a model (`DrawModel`, hunk 10).
It then captures what the game would have drawn:

* the filled polygons, from `ClipFillPolygon` (both of its entries);
* the lines and the points.

Each primitive is captured in the camera's space and drawn again with Python's PIL, in the
colours of the flight's palette (the instrument panel picture's).

Each picture is scaled to fit its panel, so sizes cannot be compared between pictures.

## How the pictures were made

The first version of these pictures had faults, since corrected:

* The carrier's deck and other parts were missing. The colour flag `$FCxx` had been taken for a
  shadow, so those faces were left out.
* The polygons drawn through `ClipFillPolygon`'s second entry were not captured. Most of the
  scenery uses that entry.
* Shapes that reached behind the camera were drawn without clipping.
* The pictures were mirrored.

The pictures were made this way:

* The shadows on the ground (colour 0) are left out. The top bits of a colour word are flags
  (for example `$8000`, drawn from both sides), not shadows.
* The camera is turned round the object, which stays still, and placed far enough away for the
  whole shape to be in front of it. What crosses the near plane is clipped, as in the game.
* Each picture uses the level of detail that gives the most detail.
* The animated models are drawn at their first frame, the timer `+$4C` at 10.

## The models

The models in `ModelTable` (hunk 16), the objects placed by the missions:

![The models](images/models.png)

![The F/A-18](images/fa18.png)

![The carrier](images/carrier.png)

Notes on the models:

* The Sidewinder and the AMRAAM are drawn with lines only: a body, the fins and a long line
  behind, probably the smoke trail.
* `$28` (also used as `$104`, the downed pilot of mission F4) is a pilot under his parachute.
  Its frames (by the timer) show the canopy opening, then lying collapsed on the ground.
* The aircraft have their landing gear down here.
* The two MiG entries share one dark shape.
* The carrier has a dark flight deck, the angled deck stepped along one side, the island and a
  hull under part of the deck.
* One airliner model serves as Air Force One, the 707 and the 767.
* `$F0`, object 15 of mission F6, is a ship like the carrier.
* `$DC` is a box under a parachute: the rescue pod of mission F4. Its frames show the canopy
  opening, then the box on the ground.
* The cruise missile (`$C8`) is drawn with lines, like the Sidewinder and the AMRAAM. Its
  nearest level of detail draws a single large panel, which looks wrong and is not shown.

## The scenery

The scenery shapes (`ObjectDrawTable` entries 17-117, hunks 42-50 and 54-56) are the San
Francisco Bay area. Each is shown from the side, then from above:

![Scenery shapes 17-55](images/scenery_a.png)

![Scenery shapes 56-117](images/scenery_b.png)

![The Golden Gate Bridge (shape 33)](images/golden_gate.png)

Some can be recognised:

* the Golden Gate Bridge in two halves (32, 33, red);
* the Bay Bridge and the bay's other bridges and causeways, in sections (34-41);
* the Transamerica Pyramid (46);
* Coit Tower (48);
* Sutro Tower (49, red and white);
* airfield control towers (86, 87).

Most of the rest are runway and taxiway markings, drawn as lines. They include the runways'
numbers (for example 64, 65).

Some shapes are not shown:

* Shapes 17-19 and 51, and a few others, draw nothing with the tool's settings.
* The shapes drawn by hunk 12's own renderer (`DrawGroundShape`: 20-26, 82-85, 89, 90 and 93-116,
  mostly hunk 70) are not captured yet. Their output does not go through the routines the tool
  hooks.

## Making the pictures

```
pip install unicorn pillow
cd tools/models
python3 gallery.py models          # out/models.png
python3 gallery2.py x              # out/scenery_a.png, out/scenery_b.png
python3 one.py m 0x50 2.5 0.45 out/fa18.png 0 480   # one model: m + ModelTable offset
python3 one.py s 33 0.45 0.0 out/gg.png 0 480        # one scenery shape: s + entry
```

The tool assembles the source with its labels first (`vasmm68k_mot` must be on the path), so
it always draws what the source holds.

* `f18emu.py` is the emulator harness: it loads the hunks, relocates them, keeps the symbols and
  hooks routines.
* `drawmodel.py` sets the scene and runs the draw routine.
* `render.py` draws what was captured.
