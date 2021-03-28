package startkr.util;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.imageio.ImageIO;

public class FileUtils {

	public Boolean makeTextFile( String filePath, String fileCn ) {
		Boolean isSuccess = false;
		
		FileWriter writer = null;
		try {
			writer = new FileWriter(filePath);
			writer.write( fileCn );
			writer.close();
			
			isSuccess = true;
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		return isSuccess;
	}

	public List<File> dir( String folderPath ) {
		List<File> list = null;
		File folder = new File( folderPath );
		if( folder.isDirectory() ) {
			File[] files = folder.listFiles();
			if( files != null && files.length > 0 ) {
				list = new ArrayList<File>();
				for( File file : files ) {
					list.add(file);
				}
			}
		}
		return list;
	}

	public List<File> dirFile( String folderPath ) {
		List<File> list = null;
		File folder = new File( folderPath );
		if( folder.isDirectory() ) {
			File[] files = folder.listFiles();
			if( files != null && files.length > 0 ) {
				list = new ArrayList<File>();
				for( File file : files ) {
					if( file.isFile() ) {
						list.add(file);
					}
				}
			}
		}
		return list;
	}

	public Boolean copyFile( String fromPath, String toPath ) {
		Boolean isSuccess = false;

		FileInputStream fis = null;
		FileOutputStream fos = null;
		try {
			fis = new FileInputStream( fromPath );
			fos = new FileOutputStream( toPath );
			
			int bytesRead = 0;
			//인풋스트림을 아웃픗스트림에 쓰기
			byte[] buffer = new byte[1024];   
			while ((bytesRead = fis.read(buffer, 0, 1024)) != -1) {
				fos.write(buffer, 0, bytesRead);
			}

			isSuccess = true;
		} catch ( FileNotFoundException fe) {
			// TODO Auto-generated catch block
			fe.printStackTrace();
		} catch ( IOException ie) {
			// TODO Auto-generated catch block
			ie.printStackTrace();
		} finally {
			try {
				fos.close();
				fis.close();
			} catch ( Exception e ) {

			}
		}

		return isSuccess;
	}

	public Boolean moveFile( String fromPath, String toPath ) {
		Boolean isSuccess = copyFile( fromPath, toPath );
		if( isSuccess ) isSuccess = deleteFile( fromPath );
		return isSuccess;
	}

	public Boolean deleteFile( String filePath ) {
		File file = new File( filePath );
		Boolean isSuccess = file.delete();
		return isSuccess;
	}
	

	public File scaleImageWidth( File originImage, int width ) {
		if( originImage == null || !originImage.exists() || !originImage.isFile() ) return null;
		if( width < 1) return null;
		
		File thumbnail = null;
		
		BufferedImage originBufferdImage = null;
		
		try {
			// origin Image
			originBufferdImage = ImageIO.read(originImage);
			int originWidth = (originBufferdImage.getWidth());
			
			float ratio = ( (float) width / (float) originWidth );
			thumbnail = scaleImage( originImage, ratio );
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return thumbnail;
	}
	
	public File scaleImageHeight( File originImage, int height ) {
		if( originImage == null || !originImage.exists() || !originImage.isFile() ) return null;
		if( height < 1) return null;
		
		File thumbnail = null;
		
		BufferedImage originBufferdImage = null;
		
		try {
			// origin Image
			originBufferdImage = ImageIO.read(originImage);
			int originHeight = (originBufferdImage.getHeight());
			
			float ratio = ( (float) height / (float) originHeight );
			thumbnail = scaleImage( originImage, ratio );
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return thumbnail;
	}
	
	public File scaleImageBox( File originImage, int width, int height ) {
		if( originImage == null || !originImage.exists() || !originImage.isFile() ) return null;
		if( height < 1) return null;
		
		File thumbnail = null;
		
		BufferedImage originBufferdImage = null;
		
		try {
			// origin Image
			originBufferdImage = ImageIO.read(originImage);
			int originWidth = (originBufferdImage.getWidth());
			int originHeight = (originBufferdImage.getHeight());
			
			float ratioWidth = ( (float) width / (float) originWidth );
			float ratioHeight = ( (float) height / (float) originHeight );
			float ratio = ( ratioWidth > ratioHeight ? ratioHeight : ratioWidth );
			thumbnail = scaleImage( originImage, ratio );
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return thumbnail;
	}
	
	public File scaleImage( File originImage, float ratio ) {
		if( originImage == null || !originImage.exists() || !originImage.isFile() ) return null;
		if( ratio < 1f) return null;
		
		File thumbnail = null;
		
		BufferedImage originBufferdImage = null;
		BufferedImage thumbBufferdImage = null;
		
		try {
			// name, path
			String imagePath = originImage.getCanonicalPath();
			String imageName = originImage.getName();
			imagePath = imagePath.replaceAll(imageName, "");
			int idx = imageName.indexOf(".");
			if( idx > -1 ) imageName = imageName.substring(0, idx);
			imagePath = imagePath + imageName + "_R"+( Math.round(ratio*1000) ) +".png";
			thumbnail = new File( imagePath );
			
			// origin Image
			originBufferdImage = ImageIO.read(originImage);
			int originWidth = (originBufferdImage.getWidth());
			int originHeight = (originBufferdImage.getHeight());
			
			int dstWidth = (int) ( (float) originWidth * ratio );
			int dstHeight = (int) ( (float) originHeight * ratio );
			
			// 썸네일 썸네일 그리기 
			thumbBufferdImage = new BufferedImage(dstWidth, dstHeight, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D g2d = thumbBufferdImage.createGraphics();
			g2d.drawImage( originBufferdImage, 0, 0, originWidth, originHeight, null);

			// 썸네일 파일 생성
			ImageIO.write(thumbBufferdImage, "png", thumbnail);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return thumbnail;
	}
	
	public File makeThumbnail( File originImage ) { // 768 X 768 정사각형
		if( originImage == null || !originImage.exists() || !originImage.isFile() ) return null;
		
		return makeThumbnail( originImage, 768 );
	}
	
	public File makeThumbnail( File originImage, int size ) { // 정사각형
		if( originImage == null || !originImage.exists() || !originImage.isFile() ) return null;
		if( size < 1 ) return null;
		
		return makeThumbnail( originImage, size, size );
	}
	
	public File makeThumbnail( File originImage, int width, int height ) {
		if( originImage == null || !originImage.exists() || !originImage.isFile() ) return null;
		if( width < 1 || height < 1 ) return null;
		
		File thumbnail = null;
		
		BufferedImage originBufferdImage = null;
		BufferedImage thumbBufferdImage = null;
		
		try {
			// name, path
			String imagePath = originImage.getCanonicalPath();
			String imageName = originImage.getName();
			imagePath = imagePath.replaceAll(imageName, "");
			int idx = imageName.indexOf(".");
			if( idx > -1 ) imageName = imageName.substring(0, idx);
			imagePath = imagePath + imageName + "_thm.png";
			thumbnail = new File( imagePath );
			
			// origin Image
			originBufferdImage = ImageIO.read(originImage);
			int originWidth = (originBufferdImage.getWidth());
			int originHeight = (originBufferdImage.getHeight());
			// case 1 : 1200, 1000 ->  100, 100
			// case 2 :  800, 1000 ->  100, 100
			
			Float originRatio = (float) originWidth / (float) originHeight;
			Float targetRatio = (float) width / (float) height;
			Float convertRatio = 1f;
			// case 1 : originRatio = 1.2, targetRatio = 1
			// case 2 : originRatio = 0.8, targetRatio = 1
			
			int srcWidth = originWidth;
			int srcHeight = originHeight;
			
			int dstx1 = 0;
			int dsty1 = 0;
			int dstx2 = originWidth;
			int dsty2 = originHeight;
			
			if( originRatio > targetRatio ) {
				convertRatio = (float) originHeight / (float) height;
				srcWidth = (int) ( (float) width * convertRatio );
				dstx1 = ( originWidth / 2 - srcWidth / 2 );
				dstx2 = ( originWidth / 2 + srcWidth / 2 );
			} else {
				convertRatio = (float) originWidth / (float) width;
				srcHeight = (int) ( (float) height * convertRatio );
				dsty1 = ( originHeight / 2 - srcHeight / 2 );
				dsty2 = ( originHeight / 2 + srcHeight / 2 );
			}
			// case 1 : convertRatio = 10, srcWidth = 1000, srcHeight = 1000 -> ( 100, 1100, 0, 1000 )
			// case 2 : convertRatio =  8, srcWidth =  800, srcHeight =  800 -> ( 100, 900, 0, 800 )
			
			// 썸네일 썸네일 그리기 
			thumbBufferdImage = new BufferedImage(width, height, BufferedImage.TYPE_3BYTE_BGR);
			Graphics2D g2d = thumbBufferdImage.createGraphics();
			g2d.drawImage( originBufferdImage,
				       dstx1, dsty1, dstx2, dsty2,
				       0, 0, width, height,
				       null);
			// 썸네일 파일 생성
			ImageIO.write(thumbBufferdImage, "png", thumbnail);
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return thumbnail;
	}
}
