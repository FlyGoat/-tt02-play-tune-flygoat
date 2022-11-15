#!/usr/bin/env python3

"""
    Python Script for generating a Verilog LUT from a RTTL ringtone

    Copyright 2022 Milosch Meriac <milosch@meriac.com>
    Location: https://github.com/meriac/tt02-play-tune/

    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions
    are met:

    1. Redistributions of source code must retain the above copyright
       notice, this list of conditions and the following disclaimer.

	2. Redistributions in binary form must reproduce the above copyright
	   notice, this list of conditions and the following disclaimer in the
	   documentation and/or other materials provided with the distribution.

	3. Neither the name of the copyright holder nor the names of its
	   contributors may be used to endorse or promote products derived
	   from this software without specific prior written permission.

	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
	"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
	LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
	A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
	HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
	SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
	LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
	DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
	THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
	(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
	OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

"""

import re
import sys
import numpy as np
import scipy.io.wavfile as wav

transpose = -4
timer_resolution_ms = 50
sampling_rate=10000
db_sz = 100

#rttl='EGOIST Planetes:d=4,o=8,b=100:48d,16p,48d,16p,16d,16p,48d,16p,16d,16p,32p,48d,16p,16d,16p,16d,16p,48d,16p,48d,16p,32p,16d,16p,16d,16p,48d,16p,32p,32p,32p,48d,16p,48d,16p,16d,16p,48d,16p,48d,16p,32p,16d,16p,48d,16p,32p,48d,16p,48d,16p,16d,16p,48d,16p,16d,16p,32p,16d,16p,48d,16p,16d,16p,48d,16p,48d,16p,32p,48d,16p,16d,16p,48d,16p,48d,16p,16d,16p,32p,32p,32p,32p,32p,32p'
#rttl="FlyGoat:d=4,o=8,b=100:16d,16p,16d,16p,48d,16p,16d,16p,32p,16d,16p,48d,16p,16d,16p,16d,16p,32p,48d,16p,16d,16p,48d,16p,48d,16p,32p,48d,16p,48d,16p,16d,16p,32p,48d,16p,48d,16p,48d,16p,32p,16d,16p,48d,16p,32p,48d,16p,32p,32p,32p,32p,32p,32p"
#rttl="BH5HSO:d=4,o=8,b=100:48d,16p,16d,16p,16d,16p,16d,16p,32p,16d,16p,16d,16p,16d,16p,16d,16p,32p,16d,16p,16d,16p,16d,16p,16d,16p,16d,16p,32p,16d,16p,16d,16p,16d,16p,16d,16p,32p,16d,16p,16d,16p,16d,16p,32p,48d,16p,48d,16p,48d,16p,32p,32p,32p,32p,32p,32p"
rttl="GM3HSO:d=4,o=8,b=100:48d,16p,48d,16p,16d,16p,32p,48d,16p,48d,16p,32p,16d,16p,16d,16p,16d,16p,48d,16p,48d,16p,32p,16d,16p,16d,16p,16d,16p,16d,16p,32p,16d,16p,16d,16p,16d,16p,32p,48d,16p,48d,16p,48d,16p,32p,32p,32p,32p,32p,32p"

data=np.zeros(0)

def rttl_verilog(index, divider, ticks, comment):
	if ticks>15:
		ticks=15

	print('{0:2}: db_entry = 11\'h{1:03x};{2}'.format(index, (divider<<4)|ticks, comment))


def rttl_append_note(freq, duration_ms):
	global sampling_rate

	samples = (duration_ms*sampling_rate)//1000
	res = np.zeros(samples)

	if freq==0:
		return res;

	period = int((sampling_rate/freq)/2)
	pos = 0
	data = 0

	for i in range(0,samples):
		if (i % period)==0:
			if data>0:
				data = -0.75
			else:
				data = 0.75
		res[i] = data

	return res

def rttl_freq(note, octave):
	translate = [
		'c',
		'c#',
		'd',
		'd#',
		'e',
		'f',
		'f#',
		'g',
		'g#',
		'a',
		'a#',
		'b'
	]
	N = translate.index(note)
	note = (octave*12)+N
	freq = 16.3516*pow(2,note/12)
	return round(freq,2)

def rttl_parse(rttl):
	global data, transpose

	# Split apart three parts of RTTL file
	title, defaults, notes = rttl.split(':')

	# Set defaults
	index = 0
	duration = False
	octave = False
	bpm = False

	# Update with actual settings
	for default in defaults.split(','):
		param, value = default.split('=')
		match param:
			case 'd': duration=int(value)
			case 'o': octave=int(value)
			case 'b': bpm=int(value)

	print('// Song:', title)
	print('// One timer-tick equals {0}ms'.format(timer_resolution_ms))
	print('// Per-note clock dividers assume {0}Hz clock'.format(sampling_rate))
	print('// Bottom-nibble is tick-count per note, upper nibbles are the per-note clock dividers')

	# Process notes
	for note_raw in notes.split(','):
		note = re.split(r'^([0-9]*)([a-hp#]+)([0-9]*)(\.*)$', note_raw)

		if note[1]:
			d = int(note[1])
		else:
			d = duration

		if note[2]:
			n = note[2]
		else:
			sys.exit('ERROR: no note in string [{0}]'.format(note_raw))

		if note[3]:
			o = int(note[3])
		else:
			o = octave

		# Calculate duration based on BPM
		duration_ms = (4*60*1000)//(bpm*d)
		# Extend duration if needed
		if note[4] == '.':
			duration_ms += duration_ms//2
		duration_ms = int(round(duration_ms/timer_resolution_ms)*timer_resolution_ms)

		# Handle pause separately from note
		if n=='p':
			freq = 0
		else:
			freq = rttl_freq(n,o+transpose) 

		# Append waveform to simulation wavefile
		data = np.append(data, rttl_append_note(freq, duration_ms))

		ticks = round(duration_ms/timer_resolution_ms)
		comment = ' // {0:3} ({1:8}, {2:3}ms, {3:2} ticks)'.format(n+str(o)+note[4], (str(freq)+'Hz') if freq>0 else 'pause', duration_ms, ticks)
		if freq:
			rttl_verilog(index, int(sampling_rate/freq), ticks, comment)
		else:
			rttl_verilog(index, 0, ticks, comment)

		index += 1

	for i in range(index, db_sz):
		# One tick to avoid being optimized away
		rttl_verilog(i, 0, 1, ' // unused')
		index += 1

rttl_parse(rttl)

# write out wave file of song for testing
wav.write('song.wav', sampling_rate, data)
