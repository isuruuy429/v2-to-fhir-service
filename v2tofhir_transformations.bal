// import wso2healthcare/healthcare.hl7v23;
import wso2healthcare/healthcare.hl7;
import ballerina/log;
import wso2healthcare/healthcare.fhir.r4;

public function transformToFHIR(hl7:Message message) returns json|error {
    r4:Bundle bundle = {'type: "searchset"};
    r4:BundleEntry[] entries = [];
    bundle.entry = entries;

    message.entries().forEach(function(anydata triggerEventField) {
        string key;
        anydata segment;
        [key, segment] = <[string, anydata]>triggerEventField;
        do {
            if segment is hl7:Segment {
                r4:BundleEntry[] bundleEntries = Generic_Segment_To_FHIR(segment.name, segment);
                foreach r4:BundleEntry entry in bundleEntries {
                    entries.push(entry);
                }
            }
            if segment is hl7:Segment[] {
                foreach hl7:Segment segmentElem in segment {
                    r4:BundleEntry[] bundleEntries = Generic_Segment_To_FHIR(segmentElem.name, segmentElem);
                    foreach r4:BundleEntry entry in bundleEntries {
                        entries.push(entry);
                    }
                }
            }
            if segment is hl7:SegmentComponent {
                segment.entries().forEach(function(anydata segmentComponentField) {
                    string groupKey;
                    anydata segmentComponent;
                    [groupKey, segmentComponent] = <[string, anydata]>segmentComponentField;
                    if segmentComponent is hl7:Segment {
                        r4:BundleEntry[] bundleEntries = Generic_Segment_To_FHIR(segmentComponent.name, segmentComponent);
                        foreach r4:BundleEntry entry in bundleEntries {
                            entries.push(entry);
                        }
                    }
                });
            }
        } on fail error e {
            log:printError("Error occurred while converting message to FHIR", e);
        }

    });
    if entries.length() > 0 {
        return bundle.toJson();
    }
    return getOperationOutcome("Unsupported message type.");
}

