package com.sumedhe.utils;

//=========================//
// Author: Christo Panchev //
//=========================//

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

public class TextGenerator
{
    static final int INSTANCE_PER_CHAR = 1;
    static final boolean isTraining = false;

    CharsData charsData = null;
    ArrayList<String> words = new ArrayList<String>(100000);

    public TextGenerator()
    {
        charsData = new CharsData();
    }

    public void loadChars(String allcharsfname, String errcharsfname, String rule1fname, String rule2fname) throws IOException
    {
        charsData.loadChars(allcharsfname, isTraining ? errcharsfname : null, rule1fname, rule2fname);
    }

    public void generateText()
    {

        // Generate text
        for (int i = 0; i < INSTANCE_PER_CHAR; i++)
        {
            charsData.shuffle();

            // Create words
            for (int idx = 0; idx < charsData.size(); idx++)
            {
                StringBuffer word = new StringBuffer();
                int wordlen = (int)(15*Math.random() + 1);

                while (word.length() <= wordlen)
                    word.append(charsData.getNextChar());

                words.add(word.toString());
            }
        }

    }

    public void writeText(String outfname) throws IOException
    {

        FileWriter outfile = new FileWriter(outfname);
        BufferedWriter fwriter = new BufferedWriter(outfile);

        int rowlen = 0;
        for (String word : words)
        {
            word = word.trim();

            if (rowlen + word.length() <= 60)
            {
                fwriter.write(" " + word);
                rowlen += word.length();
            }
            else
            {
                fwriter.write("\n" + word);
                rowlen = word.length();
            }
        }

        if (fwriter != null)
            fwriter.close();

        if (outfile != null)
            outfile.close();

        System.out.println("Generated: " + outfname+INSTANCE_PER_CHAR+".txt");
    }


}
