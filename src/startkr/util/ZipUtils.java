package startkr.util;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;
//import java.util.zip.ZipEntry;
import java.util.zip.ZipInputStream;
import java.util.zip.ZipOutputStream;

import org.apache.tools.zip.ZipEntry;

//import net.sf.jazzlib.ZipEntry;
//import net.sf.jazzlib.ZipInputStream;


public class ZipUtils {

	private static final int COMPRESSION_LEVEL = 8;

	private static final int BUFFER_SIZE = 1024 * 2;

	public File zip(List fileInfoList, String output) throws Exception {
		if( fileInfoList == null || fileInfoList.size() == 0 ) return null;

		// output 의 확장자가 zip이 아니면 리턴한다.
		if( output == null || !output.endsWith(".zip") ) {
			throw new Exception("압축 후 저장 파일명의 확장자를 확인하세요");
		}

		File zipFile = new File(output);

		byte[] buff = new byte[1024];

		FileInputStream fin = null;
		FileOutputStream fos = null;
		ZipOutputStream zos = null;

		try {
			fos = new FileOutputStream( zipFile );
			zos = new ZipOutputStream(new BufferedOutputStream( fos ));
			zos.setLevel(COMPRESSION_LEVEL); // 압축 레벨 - 최대 압축률은 9, 디폴트 8

			for (int lp0 = 0 ; lp0 < fileInfoList.size() ; lp0++ ) {
				Map fileInfo = (Map) fileInfoList.get(lp0);
				if( fileInfo != null ) {
					String fileName = (String) fileInfo.get("file_nm");
					if( fileName.equals("") ) continue;

					File file = (File) fileInfo.get("file");

					zos.putNextEntry(new ZipEntry(fileName));
					fin = new FileInputStream(file);

					// 바이트 전송
					int len;
					while ((len = fin.read(buff)) > 0) {
						zos.write(buff, 0, len);
					}

					zos.closeEntry();
					if( fin != null ) {
						fin.close();
					}
				}
			}

			zos.finish(); // ZipOutputStream finish
		} catch (FileNotFoundException fe) {
			// TODO Auto-generated catch block
			fe.printStackTrace();
		} catch (IOException ioe) {
			// TODO Auto-generated catch block
			ioe.printStackTrace();
		} catch (Exception ex) {
			// TODO Auto-generated catch block
			ex.printStackTrace();
		} finally {
			if (zos != null) {
				zos.close();
			}
			if (fos != null) {
				fos.close();
			}
		}

		return zipFile;
	}

	public static void zip(String[] filePaths, String output) throws Exception {
		if( filePaths == null || filePaths.length == 0 ) {
			throw new Exception("압축 대상의 파일을 찾을 수가 없습니다.");
		}

		// output 의 확장자가 zip이 아니면 리턴한다.
		if( output == null || !output.endsWith(".zip") ) {
			throw new Exception("압축 후 저장 파일명의 확장자를 확인하세요");
		}

	 // 파일을 읽기위한 버퍼
		byte[] buff = new byte[1024];
		ZipOutputStream out = null;
		FileInputStream in = null;
		try {
			// 압축파일명
			out = new ZipOutputStream(new FileOutputStream(output));
			out.setLevel(COMPRESSION_LEVEL); // 압축 레벨 - 최대 압축률은 9, 디폴트 8

			// 파일 압축
			for (int lp0 = 0 ; lp0 < filePaths.length ; lp0++ ) {
				in = new FileInputStream(filePaths[lp0]);

				// 압축 항목추가
				out.putNextEntry(new ZipEntry(filePaths[lp0]));

				// 바이트 전송
				int len;
				while ((len = in.read(buff)) > 0) {
					out.write(buff, 0, len);
				}

				out.closeEntry();
				in.close();
			}

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	/**
	 * 지정된 폴더를 Zip 파일로 압축한다.
	 * @param sourcePath - 압축 대상 디렉토리
	 * @param output - 저장 zip 파일 이름
	 * @throws Exception
	 */
	public static void zip(String filePath, String output) throws Exception {

		// 압축 대상(sourcePath)이 디렉토리나 파일이 아니면 리턴한다.
		File sourceFile = new File(filePath);
		if (!sourceFile.isFile() && !sourceFile.isDirectory()) {
			throw new Exception("압축 대상의 파일을 찾을 수가 없습니다.");
		}

		// output 의 확장자가 zip이 아니면 리턴한다.
		if( output == null || !output.endsWith(".zip") ) {
			throw new Exception("압축 후 저장 파일명의 확장자를 확인하세요");
		}

		FileOutputStream fos = null;
		BufferedOutputStream bos = null;
		ZipOutputStream zos = null;

		try {
			fos = new FileOutputStream(output); // FileOutputStream
			bos = new BufferedOutputStream(fos); // BufferedStream
			zos = new ZipOutputStream(bos); // ZipOutputStream
			zos.setLevel(COMPRESSION_LEVEL); // 압축 레벨 - 최대 압축률은 9, 디폴트 8
			zipEntry(sourceFile, filePath, zos); // Zip 파일 생성
			zos.finish(); // ZipOutputStream finish
		} finally {
			if (zos != null) {
				zos.close();
			}
			if (bos != null) {
				bos.close();
			}
			if (fos != null) {
				fos.close();
			}
		}
	}

	/**
	 * 압축
	 * @param sourceFile
	 * @param sourcePath
	 * @param zos
	 * @throws Exception
	 */
	private static void zipEntry(File sourceFile, String sourcePath, ZipOutputStream zos) throws Exception {
		// sourceFile 이 디렉토리인 경우 하위 파일 리스트 가져와 재귀호출
		if (sourceFile.isDirectory()) {
			if (sourceFile.getName().equalsIgnoreCase(".metadata")) { // .metadata 디렉토리 return
				return;
			}
			File[] fileArray = sourceFile.listFiles(); // sourceFile 의 하위 파일 리스트
			for (int i = 0; i < fileArray.length; i++) {
				zipEntry(fileArray[i], sourcePath, zos); // 재귀 호출
			}
		} else { // sourcehFile 이 디렉토리가 아닌 경우
			BufferedInputStream bis = null;
			try {
				String sFilePath = sourceFile.getPath();
				String zipEntryName = sFilePath.substring(sourcePath.length() + 1, sFilePath.length());

				bis = new BufferedInputStream(new FileInputStream(sourceFile));
				ZipEntry zentry = new ZipEntry(zipEntryName);
				zentry.setTime(sourceFile.lastModified());
				zos.putNextEntry(zentry);

				byte[] buffer = new byte[BUFFER_SIZE];
				int cnt = 0;
				while ((cnt = bis.read(buffer, 0, BUFFER_SIZE)) != -1) {
					zos.write(buffer, 0, cnt);
				}
				zos.closeEntry();
			} finally {
				if (bis != null) {
					bis.close();
				}
			}
		}
	}

	/**
	 * Zip 파일의 압축을 푼다.
	 *
	 * @param zipFile - 압축 풀 Zip 파일
	 * @param targetDir - 압축 푼 파일이 들어간 디렉토리
	 * @param fileNameToLowerCase - 파일명을 소문자로 바꿀지 여부
	 * @throws Exception
	 */
	public static void unzip(File zipFile, File targetDir, boolean fileNameToLowerCase) throws Exception {
		FileInputStream fis = null;
		ZipInputStream zis = null;
		ZipEntry zentry = null;

		try {
			fis = new FileInputStream(zipFile); // FileInputStream
			zis = new ZipInputStream(fis); // ZipInputStream

			while ((zentry = (ZipEntry) zis.getNextEntry()) != null) {
				String fileNameToUnzip = zentry.getName();
				if (fileNameToLowerCase) { // fileName toLowerCase
					fileNameToUnzip = fileNameToUnzip.toLowerCase();
				}

				File targetFile = new File(targetDir, fileNameToUnzip);

//				if (zentry.isDirectory()) {// Directory 인 경우
//					FileUtils.makeDir(targetFile.getAbsolutePath()); // 디렉토리 생성
//				} else { // File 인 경우
//					// parent Directory 생성
//					FileUtils.makeDir(targetFile.getParent());
//					unzipEntry(zis, targetFile);
//				}
			}
		} finally {
			if (zis != null) {
				zis.close();
			}
			if (fis != null) {
				fis.close();
			}
		}
	}

	/**
	 * Zip 파일의 한 개 엔트리의 압축을 푼다.
	 *
	 * @param zis - Zip Input Stream
	 * @param filePath - 압축 풀린 파일의 경로
	 * @return
	 * @throws Exception
	 */
	protected static File unzipEntry(ZipInputStream zis, File targetFile) throws Exception {
		FileOutputStream fos = null;
		try {
			fos = new FileOutputStream(targetFile);

			byte[] buffer = new byte[BUFFER_SIZE];
			int len = 0;
			while ((len = zis.read(buffer)) != -1) {
				fos.write(buffer, 0, len);
			}
		} finally {
			if (fos != null) {
				fos.close();
			}
		}
		return targetFile;
	}


}
