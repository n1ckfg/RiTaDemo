"use strict";

let castleImg, forestImg, villageImg, currentImg;
let message = "";
let result = "";
let font = "Arial";
let fontSize = 20;
let fontColor, fontShadowColor;
let textPos, shadowPos;

function preload() {
	castleImg = loadImage("./images/castle.jpg");
	forestImg = loadImage("./images/forest.jpg");
	villageImg = loadImage("./images/village.jpg");
}

function setup() {
	createCanvas(640, 480);
	
    fontColor = color(255);
    fontShadowColor = color(0);

	textFont(font);
    textSize(fontSize);
	textAlign(CENTER);
	textPos = createVector(width/2, height - (fontSize * 2));
	shadowPos = createVector(textPos.x + 2, textPos.y + 2);
	

	currentImg = castleImg;
}

function draw() {
	if (result.toLowerCase().includes("castle")) {
		currentImg = castleImg;
	} else if (result.toLowerCase().includes("forest")) {
		currentImg = forestImg;
	} else if (result.toLowerCase().includes("village")) {
		currentImg = villageImg;
	}
	
	image(currentImg, 0, 0, width, height);		
	
	fill(fontShadowColor);
	text(message, shadowPos.x, shadowPos.y);
	fill(fontColor);
	text(message, textPos.x, textPos.y);
}