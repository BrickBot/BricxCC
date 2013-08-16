(*
 * The contents of this file are subject to the Mozilla Public License
 * Version 1.1 (the "License"); you may not use this file except in
 * compliance with the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS"
 * basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See the
 * License for the specific language governing rights and limitations
 * under the License.
 *
 * The Initial Developer of this code is John Hansen.
 * Portions created by John Hansen are Copyright (C) 2009-2013 John Hansen.
 * All Rights Reserved.
 *
 *)
unit uImgFormats;

interface

type
  TPixelBytes = array of byte;
  TPixelFormat = (pfNXT, pfEV3, pfFB0);
  TImageFormat = (ifXBM, ifP1, ifP4, ifBMP, ifPNG);

function TransformPixels(inPixFormat : TPixelFormat; outPixFormat : TPixelFormat;
  pixelData : TPixelBytes) : TPixelBytes;

procedure SavePixelsToFile(pixFormat : TPixelFormat; pixelData : TPixelBytes;
  srcWidth, srcHeight : byte; imgFormat : TImageFormat; const Filename : string);


implementation

uses
  Classes, SysUtils;

function TransformPixels(inPixFormat : TPixelFormat; outPixFormat : TPixelFormat;
  pixelData : TPixelBytes) : TPixelBytes;
begin
  if (inPixFormat = outPixFormat) then
  begin
    Result := pixelData;
  end
  else
  begin
  end;
end;

procedure SavePixelsToFile(pixFormat : TPixelFormat; pixelData : TPixelBytes;
  srcWidth, srcHeight : byte; imgFormat : TImageFormat; const Filename : string);
begin
(*
    if IsNXT then
    begin
      bmp.Width  := 100;
      bmp.Height := 64;
      for line := 0 to 7 do
      begin
        for x := 0 to 99 do
        begin
          b := fBytes[line*100 + x];
          for i := 0 to 7 do
          begin
            bmp.Canvas.Pixels[x, line*8+i] := GetPixelColor(b, i);
          end;
        end;
      end;
    end
    else if IsEV3 then
    begin
      bmp.Width  := 178;
      bmp.Height := 128;
      for line := 0 to 127 do
      begin
        for x := 0 to 22 do
        begin
          b := fBytes[line*23 + x];
          for i := 0 to 7 do
          begin
            bmp.Canvas.Pixels[x*8+i, line] := GetPixelColor(b, 7-i);
          end;
        end;
        // last 2 bits of each line
        x := 23;
        b := fBytes[line*23 + x];
        for i := 0 to 1 do
        begin
          bmp.Canvas.Pixels[x*8+i, line] := GetPixelColor(b, 7-i);
        end;
      end;
    end;
*)
end;

(*
   /* Table of CRCs of all 8-bit messages. */
   unsigned long crc_table[256];

   /* Flag: has the table been computed? Initially false. */
   int crc_table_computed = 0;

   /* Make the table for a fast CRC. */
   void make_crc_table(void)
   {
     unsigned long c;
     int n, k;

     for (n = 0; n < 256; n++) {
       c = (unsigned long) n;
       for (k = 0; k < 8; k++) {
         if (c & 1)
           c = 0xedb88320L ^ (c >> 1);
         else
           c = c >> 1;
       }
       crc_table[n] = c;
     }
     crc_table_computed = 1;
   }

   /* Update a running CRC with the bytes buf[0..len-1]--the CRC
      should be initialized to all 1's, and the transmitted value
      is the 1's complement of the final running CRC (see the
      crc() routine below)). */

   unsigned long update_crc(unsigned long crc, unsigned char *buf,
                            int len)
   {
     unsigned long c = crc;
     int n;

     if (!crc_table_computed)
       make_crc_table();
     for (n = 0; n < len; n++) {
       c = crc_table[(c ^ buf[n]) & 0xff] ^ (c >> 8);
     }
     return c;
   }

   /* Return the CRC of the bytes buf[0..len-1]. */
   unsigned long crc(unsigned char *buf, int len)
   {
     return update_crc(0xffffffffL, buf, len) ^ 0xffffffffL;
   }
*)


end.