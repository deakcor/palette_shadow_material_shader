
# Palette shadow material shader
A toon shader allowing to choose the color palette of a material. For godot engine.

## Preview

With a classic palette.

![](https://github.com/deakcor/palette_shadow_material/blob/master/preview.png)

Or with a wtf palette as you want.

![](https://github.com/deakcor/palette_shadow_material/blob/master/preview2.png)

Now with the texture version.

![](https://github.com/deakcor/palette_shadow_material/blob/master/preview3.png)

I used this palette. (row 1 : normal color, row 2 : shadow color). /!\ I zoomed the palette for the readme but a color must be of 1 pixel.

![](https://github.com/deakcor/palette_shadow_material/blob/master/palette.png)

Specular + rim. (You can get it in the folder example)

![](https://github.com/deakcor/palette_shadow_material/blob/master/example/preview.gif)

## Parameters
### Without texture
3 colors to choose and a range which allows you to choose at which intensity step to change color.
### With texture
**Color_light** and **Color_shadow** (optional, set alpha to 0 to use texture instead)

**palette** palette image, 1 pixel per color (row 1 : normal color, row 2 : shadow color).
**Tex** Texture image.

**Specular color**
**Glow reduction** (specular size)

**Rim amount** (0: no rim, 1: full)

**Step** (at which intensity step to change color)
