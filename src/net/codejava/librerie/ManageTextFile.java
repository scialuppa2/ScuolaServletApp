package librerie;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class ManageTextFile {
    private String sFilePath;
    private FileReader fr = null;
    private FileWriter fw = null;
    private BufferedReader br = null;
    private BufferedWriter bw = null;

    public ManageTextFile(String sFilePath) {
        this.sFilePath = sFilePath;
    }

    public boolean openFile(int i1Read2Write, boolean bAppend) {
        try {
            switch (i1Read2Write) {
                case 1:
                	fr = new FileReader(sFilePath);
                	if(fr!=null) {
                		br = new BufferedReader(fr);                		
                	}
                    return true;
                case 2:
                	fw = new FileWriter(sFilePath, bAppend);
                	if(fw!=null) {
                		bw = new BufferedWriter(bw);                		
                	}
                    return true;
                default:
                    return false;
            }
        } catch (Exception e) {
            e.printStackTrace();
            br = null;
            bw = null;
            return false;
        }
    }

    public boolean writeInFile(String sTextToWrite) {
        if (bw == null) {
            return false;
        }
        try {
            bw.write(sTextToWrite);
            bw.write(System.lineSeparator());
            bw.flush();
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public String readNextLine() {
        if (br == null) {
            return null;
        }
        try {
            return br.readLine();
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean closeFile() {
        try {
            if (br != null) {
                br.close();
            }
            if (bw != null) {
                bw.close();
            }
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean removeFirstLine() {
        List<String> lines = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(sFilePath))) {
            String line;
            boolean isFirstLine = true;
            while ((line = reader.readLine()) != null) {
                if (!isFirstLine) {
                    lines.add(line);
                }
                isFirstLine = false;
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(sFilePath))) {
            for (String line : lines) {
                writer.write(line);
                writer.write(System.lineSeparator());
            }
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
        return true;
    }
}
