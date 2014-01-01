/**
	Audio Spectrum Analyzer Example
	A simple example for doing audio spectrum analysis in ActionScript 3.
			 	
	Copyright (C) 2009 Mike Creighton
			
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
			
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
			
	You should have received a copy of the GNU General Public License
	along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */
package {
	import fl.motion.easing.Quadratic;	
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundMixer;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;		

	/**
	 * @author Mike Creighton
	 */
	public class BasicAnalyzer extends Sprite {

		private const BAR_MAX_HEIGHT : int = 174; // The maximum height for each bar.
		private const BAR_WIDTH : int = 9; // The width of each bar.
		private const BAR_SPACING : int = 2; // The number of pixels between each bar.
		private const NUM_SEGMENTS : int = 48; // Defines how many bars you'll have across.	
		private const MARGIN : int = 16; // The amount of margin on the edges of the stage.
		
		// You don't want to touch this value since it's based on the number
		// of values within each stereo channel
		private const CHANNEL_LENGTH : int = 256;
		
		private const VALUES_PER_SEGMENT : int = Math.floor(CHANNEL_LENGTH / NUM_SEGMENTS);
		
		private var segmentTotals : Array;
		private var barsHolder : Sprite;
		private var bars : Array;

		public function BasicAnalyzer() {
			
			// Set up a sprite to hold all of our special bars
			// and create each of the bars based on the NUM_SEGMENTS
			barsHolder = new Sprite();
			addChild(barsHolder);
			barsHolder.x = MARGIN;
			barsHolder.y = MARGIN * 2 + BAR_MAX_HEIGHT;
			bars = new Array();
			var bar : Bar;
			// Create all of our Bar instances.
			for (var i : int = 0; i < NUM_SEGMENTS; i++) {
				bar = new Bar(BAR_MAX_HEIGHT, BAR_WIDTH);
				bar.x = i * (BAR_WIDTH + BAR_SPACING);
				barsHolder.addChild(bar);
				bars.push(bar);
			}
			
			segmentTotals = new Array(NUM_SEGMENTS);
			
			// Create a new Sound object for loading our MP3
			var snd : Sound = new Sound();
			var req : URLRequest = new URLRequest("example.mp3"); // Replace the MP3 name with your own MP3.
			snd.load(req);
			
			var channel : SoundChannel;
			channel = snd.play();
			// Listen for the SOUND_COMPLETE event on the 
			// SoundChannel our MP3 is playing back from.  
			channel.addEventListener(Event.SOUND_COMPLETE, onPlaybackComplete);
			
			// Create a callback where we look at the audio spectrum
			addEventListener(Event.ENTER_FRAME, onEnterFrame);
		}

		/**
			All drawing logic occurs here, once per frame redraw.
		 */
		private function onEnterFrame(event : Event) : void {
			
			var newBarHeight : Number = 0;
			var segmentCounter : Number = 0;
			var channelCounter : Number = 0;
			var valuesAverage : Number = 0;
			var diff : Number = 0;
			var i : int;
			var n : Number = 0;
			
			// Zero out all the values
			for (i = 0; i < segmentTotals.length; i++) {
				segmentTotals[i] = 0;
			}
			
			var bytes : ByteArray = new ByteArray();
			// Take a picture of the audio data that's playing
			SoundMixer.computeSpectrum(bytes, true, 0);
			
			// At this point, we've just filled up our bytes
			// ByteArray with 512 pieces of data.
			//
			// The first 256 pieces in the ByteArray contain the 
			// FFT data for the left stereo channel of the audio.
			// The second 256 pieces in the ByteArray contain the
			// FFT data for the right stereo channel of the audio.
			
			// Let's start with the left channel (first 256 values)
			for (segmentCounter = 0; segmentCounter < NUM_SEGMENTS; segmentCounter++) {
				for (i = 0; i < VALUES_PER_SEGMENT; i++) {
					// We'll grab one of the 512 values out of our ByteArray.		
					n = Math.abs(bytes.readFloat());
					// And we'll add that to our totals array
					segmentTotals[segmentCounter] += n;
					// Keep track of how many channels we've read off our ByteArray.
					channelCounter++; 
				}
			}
			
			// We need to read off any remaining values in our ByteArray
			// so that we can get to the next 256 channels (right stereo values).
			diff = CHANNEL_LENGTH - channelCounter;
			if(diff > 0) {
				for (i = 0; i < diff; i++) {
					bytes.readFloat();
					channelCounter++;
				}
			}
			
			// And we'll do the exact same thing for the right side.
			// We don't need to worry about reading off the remainder
			// from the ByteArray, since we're not using that data.
			channelCounter = 0;
			for (segmentCounter = 0; segmentCounter < NUM_SEGMENTS; segmentCounter++) {
				for (i = 0; i < VALUES_PER_SEGMENT; i++) {
					// We'll grab one of the 512 values out of our ByteArray.		
					n = Math.abs(bytes.readFloat());
					// And we'll add that to our totals array
					segmentTotals[segmentCounter] += n;
					// Keep track of how many channels we've read off our ByteArray.
					channelCounter++; 
				}
			}
			
			// Grab a reference to our graphics property.
			var g : Graphics = graphics;
			g.clear();			
			
			// Draw a basic box around our normal bars.
			g.beginFill(0xFFFFFF, 0.10);
			g.drawRect(	MARGIN, 
						MARGIN, 
						NUM_SEGMENTS * (BAR_WIDTH + BAR_SPACING) - BAR_SPACING, 
						BAR_MAX_HEIGHT);
			// And one around our special bars.
			g.drawRect(	MARGIN, 
						MARGIN * 2 + BAR_MAX_HEIGHT, 
						NUM_SEGMENTS * (BAR_WIDTH + BAR_SPACING) - BAR_SPACING, 
						BAR_MAX_HEIGHT);
			g.endFill();
			
			// Go through all values in the ByteArray
			var bar : Bar;
			
			for (i = 0; i < segmentTotals.length; i++) {
				// Average the values we stuck in each segmentTotals index.
				valuesAverage = segmentTotals[i] / (VALUES_PER_SEGMENT * 2);
				valuesAverage = Quadratic.easeOut(valuesAverage, 0, 1, 1);
				if(valuesAverage > 1)
					valuesAverage = 1;
				// Derive the new height from that averaged value.
				newBarHeight = valuesAverage * BAR_MAX_HEIGHT;
				
				// Draw a basic segment bar.
				g.beginFill(0x777777);
				g.drawRect(MARGIN + i * (BAR_WIDTH + BAR_SPACING), MARGIN + (BAR_MAX_HEIGHT - newBarHeight), BAR_WIDTH, newBarHeight);
				g.endFill();
				
				// Update one of our special super-duper bars.
				bar = bars[i] as Bar;
				bar.update(valuesAverage);
			}
		}

		private function onPlaybackComplete(event : Event) : void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
		}
	}
}

/*
	We're going to use an internal class here to represent our Bar sprite.
*/
import flash.display.Sprite;
import flash.display.Graphics;
import fl.motion.Color;

import flash.geom.Matrix;
import flash.display.GradientType;

class Bar extends Sprite {
	
	private var maxHeight : Number;
	private var barWidth : Number;
	private var currentValue : Number;

	public function Bar(maxHeight : Number, barWidth : Number) {
		this.maxHeight = maxHeight;
		this.barWidth = barWidth;
		currentValue = 0;
		update(currentValue);
	}

	public function update(value : Number) : void {
		var g : Graphics = graphics;
		g.clear();
		
		// We only want to accept the passed in "value" if it is
		// greater than our currentValue.
		if(value >= currentValue) {
			currentValue = value;		
		} else {
			// We'll apply some easing to reduce the currentValue so
			// that it approaches 0.
			currentValue += (0 - currentValue) / 9; 
			if(currentValue < 0)
				currentValue = 0;
		}
		
		// Draw the bar itself, using a color that gets brighter based on currentValue.
		var newHeight : Number = Math.round(currentValue * maxHeight);
		var newColor : uint = Color.interpolateColor(0x222222, 0xFFFFFF, currentValue);
		var matrix : Matrix = new Matrix();
		matrix.createGradientBox(barWidth, newHeight, 90 * Math.PI / 180, 0, maxHeight - newHeight);
		var colors:Array = [newColor, 0x222222];
		var alphas:Array = [1, 1];
		var ratios:Array = [0, 0xFF];
		g.beginGradientFill(GradientType.LINEAR, colors, alphas, ratios, matrix);
		g.drawRect(0, maxHeight - newHeight, barWidth, newHeight);
		g.endFill();
		
		// Cap it with a line.
		g.beginFill(0xC8E656);
		g.drawRect(0, maxHeight - newHeight, barWidth, 1);
		g.endFill();
	}
}