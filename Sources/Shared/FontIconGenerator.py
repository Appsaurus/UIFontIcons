#Usage: python FontIconGenerator.py absolut/Path/To/IconFont.svg

#! /usr/bin/python

import sys
import os

from xml.dom import minidom
for font_file in sys.argv[1:]:
    font_name = font_file.split('/')[-1].replace('.svg', '')

    #doc = minidom.parse(os.path.expanduser(font_file))
    doc = minidom.parse(font_file)

    swift_output_string = """
import UIFontIcons

public enum %s: String, FontIconEnum {
    """ % font_name


    glyph_count = 0
    for glyph in doc.getElementsByTagName('glyph'):
        name = glyph.getAttribute('glyph-name')
        if name:
            name = name.title().replace('-', '')
            unicode = glyph.getAttribute('unicode')
            unicode = unicode.encode('unicode-escape').decode()
            unicode = unicode.replace('u', 'u{') + '}'
            swift_output_string += 'case %s = "%s"\n    ' % (name, unicode)
            glyph_count += 1


    swift_output_string += """
    public static func name() -> String{
        return "%s"
    }""" % font_name
    
    swift_output_string += '\n}'

    print(swift_output_string)
    swift_file_name = "%s.swift" % font_name
    swift_file_path = os.path.dirname(os.path.abspath(font_file)) + "/" + swift_file_name
    print(swift_file_path)
    fout = open(swift_file_path, 'w')
    fout.write(swift_output_string)
    fout.close()

    doc.unlink()
