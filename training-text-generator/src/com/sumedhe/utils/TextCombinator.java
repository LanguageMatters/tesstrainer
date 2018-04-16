package com.sumedhe.utils;

//=========================//
// Author: Christo Panchev //
//=========================//

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

public class TextCombinator {

    static final boolean isTraining = false;
    static final String SPACE = isTraining ? "   " : " ";
    static final String NEWLINE = isTraining ? "\t\n" : "\n";

    public static void main(String[] args) throws IOException
    {

        String[] punchars =
                {
                        "§", "‘", "“", "«", // pre 4
                        ",", ".", ",", ".", "...", ";", "?", "!", "’", "`", "”", "»", // post 15
                        "&", "*", "-", ":",
                        "\\", "|", "/", "—", "~", "\"", "'", "@"
                };
        int punchars_pre = 4;
        int punchars_post = 15;

        String[] digichars =
                {
                        "#", "(", "[", "{", // pre 4
                        "%", ")", "]", "}", // post 8
                        ".", "*", "+", "-", "/", "<", "=", ">",
                };
        int digichars_pre = 4;
        int digichars_post = 8;


        ArrayList<String> words = new ArrayList<String>(100000);

        // Load texts from args[1], args[2], ..
        for (int argi = 1; argi < args.length; argi++)
            if (!args[argi].startsWith("#"))
            {
                FileReader infile = null;
                try
                {
                    infile = new FileReader(args[argi]);
                    BufferedReader freader = new BufferedReader(infile);

                    if (freader != null)
                    {
                        System.out.println("Loading: " + args[argi]);
                        String line = null;
                        while ((line = freader.readLine()) != null)
                        {
                            for (String word : line.split(" "))
                                if (word != null && word.length() > 0)
                                    words.add(word);
                        }
                        freader.close();
                        infile.close();
                    }
                }
                catch (FileNotFoundException e)
                {
                    System.out.println("Cannot open " + args[argi] + ": " + e);
                }
            }

        // Shuffle words
        for (int idx = 0; idx < words.size(); idx++)
        {
            int idx2 = (int)(words.size() * Math.random());
            String tmp = words.get(idx2);

            // insert punc chars
            double insert_prob = isTraining ? Math.random() : 1; // probability to add punctuation
            int char_idx = (int)(punchars.length * Math.random()); // index of punctuation sign

            if (insert_prob < 0.15) // print char alone
                tmp = punchars[char_idx] + SPACE + tmp;
            else if (insert_prob < 0.3 && char_idx < punchars_pre) // insert pre
                tmp = punchars[char_idx] + tmp;
            else if (insert_prob < 0.3 && char_idx < punchars_post) // insert post
                tmp = tmp + punchars[char_idx];
            else if (insert_prob < 0.3) // insert other alone
                tmp = punchars[char_idx] + SPACE + tmp;

            // insert digits
            insert_prob = isTraining ? Math.random() : 1;
            char_idx = (int)(digichars.length * Math.random());

            if (insert_prob < 0.15 && char_idx < digichars_pre) // insert pre
            {
                String num = String.valueOf((int)(1000 * Math.random()));
                tmp = tmp + SPACE + digichars[char_idx] + num;
            }
            else if (insert_prob < 0.15 && char_idx < digichars_post) // insert post
            {
                String num = String.valueOf((int)(1000 * Math.random()));
                tmp = tmp + SPACE + num + digichars[char_idx];
            }
            else if (insert_prob < 0.15) // insert mid
            {
                String num1 = String.valueOf((int)(1000 * Math.random()));
                String num2 = String.valueOf((int)(1000 * Math.random()));
                tmp = tmp + SPACE + num1 + digichars[char_idx] + num2;
            }
            words.set(idx2, words.get(idx));
            words.set(idx, tmp);

        }

        // Write out

        // First arg is output file
        FileWriter outfile = new FileWriter(args[0]);
        BufferedWriter fwriter = new BufferedWriter(outfile);

        int rowlen = 0;
        for (String word : words)
        {
            if (rowlen + word.length() <= 60)
            {
                fwriter.write(SPACE + word);
                rowlen += word.length();
            }
            else
            {
                fwriter.write(NEWLINE + word);
                rowlen = word.length();
            }
        }
        if (fwriter != null)
            fwriter.close();

        if (outfile != null)
            outfile.close();
        System.out.println("Wrote: " + args[0]);
    }

}
