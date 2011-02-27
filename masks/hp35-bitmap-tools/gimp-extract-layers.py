#!/usr/bin/env python

# place this in your ~/.gimp-2.6/plug-ins directory

from gimpfu import *

def extract_layers(timg, tdrawable):
  x = timg.width
  y = timg.height

  layer = {}
  for l in timg.layers:
    layer[l.name] = l

  for x in ['metal','diffusion','gate','contact','implant','pad']:
    timg.active_layer = layer[x]
    pdb.gimp_edit_copy(timg.active_layer)
    img = pdb.gimp_edit_paste_as_new()
    img.disable_undo()
    pdb.gimp_image_convert_grayscale(img)
    pdb.gimp_image_flatten(img)
    pdb.gimp_threshold(img.layers[0],0,127)
    filename = x+'.png'
    pdb.gimp_file_save(img, img.active_layer, filename, filename) 

register(
        "extract_layers",
        "Extract individual layers from a multilayer image",
        "Extract individual layers from a multilayer image",
        "Peter Monta",
        "Peter Monta",
        "2010",
        "<Image>/_Xtns/_Extract Layers",
        "",
        [],
        [],
        extract_layers)

main()
