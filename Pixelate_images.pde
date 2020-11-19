float t_q = 0;
boolean clicked = false;
PImage img2, res2;
String name = "recife"; 
String ext = ".jpg";
//pt-br: coloque o nome da sua imagem e extensão(jpg, png) acima
//en: Put the name and extension(jpg, png) of your image above

void settings(){

	PImage im = loadImage(name+ext); 				//pt-br: Sempre carrega display com 720p para vizualização
	float prop = (im.width*1.0)/(im.height*1.0);//en: Always set the display with 720p for vizualization
	float h = 720; 
	size(floor(h*prop), floor(h), P2D);

}

void setup(){
	
	frameRate(15);			 
	img2 = loadImage(name+ext); //pt-br: Carrega a imagem
}								//en: load the image			

void draw(){
	
	background(0);

	t_q = floor(map(mouseY,0,height,0,height/22.0)); //pt-br: A altura do mouse ajusta o tamanho dos quadrados
	res2 = pixelate(img2, int(t_q));                 //en: The mouse's heigth adjusts the size of the squares
	
	loadPixels();
	image(res2, 0, 0, width, height);

	noLoop();

	if(clicked){								   //pt-br:Salva a imagem pixelada com um click
		res2.save(name+int(random(0, 10000))+".png"); //en: Saves the pixelate image with a click
		clicked = false;
	}

}


void mousePressed(){
	clicked = true;
}

void mouseMoved(){
	loop();
}

PImage pixelate(PImage img, int t_q){ //pt-br: (imagem, tamanho do quadrado em pixels)
									  //en: (image, square's size)
	int index = 0, aux = 0;
	PImage res = createImage(img.width,img.height,RGB);

	if(t_q != 0){
		for (int x = int(t_q); x < img.width+2*t_q; x+=2*t_q) {		
			for (int y = int(t_q);  y < img.height+2*t_q; y+=2*t_q) {
					
				index = (x+y*img.width);
						
				if (x >= img.width)                     //pt-br: Repete a última sample das linhas
					index = (x-2*int(t_q)+y*img.width); //en: Repeate the lasts samples of the rows
					
				if (y >= img.height)                     //Repete a última sample das colunas
					index = (x+(y-2*int(t_q))*img.width);//en: Repeate the lasts samples of the colunes
					
				for (int i = 0; i < 2*t_q && (i+x-int(t_q)) < img.width; ++i) {      //pt-br: Desenha os quadrados baseados em uma única sample
					for (int j = 0; j < 2*t_q && (j+y-int(t_q))< img.height ; ++j) { //en: Draw squares with one sample
						
						aux = (i+x-int(t_q))+(j+y-int(t_q))*img.width;
						res.pixels[aux] = img.pixels[index];
							
					}
				}
			}
			
		}
							
	}
	else{
			
		for (int x = 0; x < img.width; x++) {      //pt-br: Copia a imagem sem alterações, caso o tamanho do quadrado seja 0;
			for (int y = 0;  y < img.height; y++){ //en: Copy the image without modifications
					
				index = x+y*img.width;
				res.pixels[index] = img.pixels[index];
			}
		}
	}
				//pt-br: Retorna a imagem;
	return res; //en: Return the image
}
