package com.sumedhe.utils;

//=========================//
// Author: Christo Panchev //
//=========================//

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class CharsData
{
    ArrayList<String> allchars = new ArrayList<String>(5000);
    ArrayList<String> rule1chars = new ArrayList<String>(1000);
    ArrayList<String> rule2chars = new ArrayList<String>(1000);

    int currentIdx;

    CharsData()
    {
        currentIdx = 0;
    }

    public void loadChars(String allcharsfname, String errcharsfname, String rule1fname, String rule2fname) throws IOException
    {
        FileReader charsfile = new FileReader(allcharsfname);
        BufferedReader charsreader = new BufferedReader(charsfile);

        if (charsreader != null)
        {
            String line = null;
            while ((line = charsreader.readLine()) != null)
            {
                for (String allchar : line.split(","))
                    if (allchar != null && allchar.length() > 0)
                        allchars.add(allchar);
            }
            charsreader.close();
        }
        charsfile.close();
        System.out.println("Loaded " + allchars.size() + " chars from " + allcharsfname);

        if (errcharsfname != null)
        {
            charsfile = new FileReader(errcharsfname);
            charsreader = new BufferedReader(charsfile);

            if (charsreader != null)
            {
                String line = null;
                while ((line = charsreader.readLine()) != null)
                {
                    for (String allchar : line.split(","))
                        if (allchar != null && allchar.length() > 0)
                            allchars.add(allchar);
                }
                charsreader.close();
            }
            charsfile.close();
            System.out.println("Loaded " + allchars.size() + " chars from " + errcharsfname);
        }
        charsfile = new FileReader(rule1fname);
        charsreader = new BufferedReader(charsfile);

        if (charsreader != null)
        {
            String line = null;
            while ((line = charsreader.readLine()) != null)
            {
                for (String rule1char : line.split(","))
                    if (rule1char != null && rule1char.length() > 0)
                        rule1chars.add(rule1char);
            }
            charsreader.close();
        }
        charsfile.close();
        System.out.println("Loaded " + rule1chars.size() + " chars from " + rule1fname);

        charsfile = new FileReader(rule2fname);
        charsreader = new BufferedReader(charsfile);
        if (charsreader != null)
        {
            String line = null;
            while ((line = charsreader.readLine()) != null)
            {
                for (String rule2char : line.split(","))
                    if (rule2char != null && rule2char.length() > 0)
                        rule2chars.add(rule2char);
            }
            charsreader.close();
        }
        charsfile.close();
        System.out.println("Loaded " + rule2chars.size() + " chars from " + rule2fname);
    }

    public void shuffle()
    {
        for (int idx = 0; idx < allchars.size(); idx++)
        {
            int idx2 = (int)(allchars.size() * Math.random());
            String tmp = allchars.get(idx2);
            allchars.set(idx2, allchars.get(idx));
            allchars.set(idx, tmp);
        }
        currentIdx = 0;
    }

    public String getRandomChar()
    {
        int idx = (int)(allchars.size() * Math.random());
        String nextChar = allchars.get(idx);

        // Check rule 1
        if (rule1chars.indexOf(nextChar) != -1)
            return " " + nextChar + getRandomChar();
            // Check rule 2
        else if (rule2chars.indexOf(nextChar) != -1)
            return getRandomChar() + nextChar;
        else return nextChar;
    }

    public String getNextChar()
    {
        String nextChar = allchars.get(currentIdx);
        currentIdx = (currentIdx + 1) % allchars.size();

        // Check rule 1 (beginning of word only)
        if (rule1chars.indexOf(nextChar) != -1)
            return " " + nextChar + getNextChar();
            // Check rule 2 (middle of word only)
        else if (rule2chars.indexOf(nextChar) != -1)
            return getNextChar() + nextChar;
        else return nextChar;
    }

    public int size()
    {
        return allchars.size();
    }
}
