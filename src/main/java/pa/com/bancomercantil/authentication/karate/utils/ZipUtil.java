package pa.com.bancomercantil.authentication.karate.utils;

import java.io.*;
import java.nio.file.*;
import java.util.stream.Stream;
import java.util.zip.*;
import java.util.logging.*;
import java.util.function.Supplier;

public class ZipUtil {
    private static final Logger logger = Logger.getLogger(ZipUtil.class.getName());

    public static void zipDirectory(String dirPath, String zipFilePath) throws IOException {
        Path zipFile = Paths.get(zipFilePath);
        try (ZipOutputStream zipOut = new ZipOutputStream(new BufferedOutputStream(new FileOutputStream(zipFile.toFile())));
             Stream<Path> paths = Files.walk(Paths.get(dirPath))) {
            paths.filter(path -> !Files.isDirectory(path))
                 .forEach(path -> {
                     try {
                         zipOut.putNextEntry(new ZipEntry(Paths.get(dirPath).relativize(path).toString()));
                         try (BufferedInputStream bis = new BufferedInputStream(Files.newInputStream(path))) {
                             byte[] buffer = new byte[1024];
                             int length;
                             while ((length = bis.read(buffer)) > 0) {
                                 zipOut.write(buffer, 0, length);
                             }
                         }
                         zipOut.closeEntry();
                     } catch (IOException e) {
                         logSevere(() -> "Failed to zip file: " + path, e);
                     }
                 });
        }
    }

    private static void logSevere(Supplier<String> messageSupplier, Throwable throwable) {
        if (logger.isLoggable(Level.SEVERE)) {
            logger.log(Level.SEVERE, messageSupplier.get(), throwable);
        }
    }
}