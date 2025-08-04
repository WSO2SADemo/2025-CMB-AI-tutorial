import ballerina/ai;
import ballerina/log;

import xlibb/pdfbox;
import ballerina/file;
import ballerina/io;

public function main() returns error? {
    do {
    file:MetaData[] policiesDir = check file:readDir("./policies");
    
    foreach file:MetaData dirEntry in policiesDir {
        if dirEntry.dir {
            string folderPath = dirEntry.absPath;
            string policyPdfPath = folderPath + "/policies.pdf";
            string metadataJsonPath = folderPath + "/metadata.json";
            
            // Try to read the files directly
            string[] hotelPolicyPages = check pdfbox:toTextFromFile(policyPdfPath);
            json metadataResult = check io:fileReadJson(metadataJsonPath);

            string hotelPolicy = "";
            foreach string item in hotelPolicyPages {
                hotelPolicy = hotelPolicy + item;
            }

            Metadata metadata = check metadataResult.cloneWithType();
            
            ai:TextDocument document = {
                content: hotelPolicy,
                metadata: metadata
            };
            
            ai:Chunk[] chunkDocumentRecursively = check ai:chunkDocumentRecursively(document);
            check aiVectorknowledgebase.ingest(chunkDocumentRecursively);
            
            io:println("Successfully ingested policy from: " + folderPath);
        }
    }

    } on fail error e {
        log:printError("Error occurred", 'error = e);
        return e;
    }
}
