package com.sumedhe;

import com.sumedhe.utils.TextGenerator;

import java.nio.file.Paths;

public class App {

    private static String resourcesDir;
    private static String allCharsPath;
    private static String errorCharsPath;
    private static String rule1charsPath;
    private static String rule2charsPath;
    private static String outfilePath;

    public static void main(String[] args) {

        resourcesDir = Paths.get("resources").toAbsolutePath().toString();
        outfilePath    = Paths.get("output/sin.training_text").toAbsolutePath().toString();

        allCharsPath   = resourcesDir + "/allchars.csv";
        errorCharsPath = resourcesDir + "/errorchars.csv";
        rule1charsPath = resourcesDir + "/rule1chars.csv";
        rule2charsPath = resourcesDir + "/rule2chars.csv";

        TextGenerator generator = new TextGenerator();
        try {
            generator.loadChars(allCharsPath, errorCharsPath, rule1charsPath, rule2charsPath);
            generator.generateText();
            generator.writeText(outfilePath);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
