import wso2healthcare/healthcare.hl7v23;
import wso2healthcare/healthcare.hl7;
import wso2healthcare/healthcare.fhir.r4;

public function transformToFHIR(hl7:Message message) returns json {
    r4:Bundle bundle = {'type: "searchset"};
    r4:BundleEntry[] entries = [];
    bundle.entry = entries;
    if message is hl7v23:ADR_A19 {
        // This utility function is used to convert ADR_A19 message into FHIR Patient resources. This has pre-build mapping done from the
        // Implementation guide: https://build.fhir.org/ig/HL7/v2-to-fhir/branches/master/index.html.
        // In upcoming releases these utility functions will be provided as inbuilt mapping functions by WSO2 Healthcare Accelerator packages.
        r4:Patient[] patients = HL7V23_ADR_A19ToPatient(message);
        foreach r4:Patient patient in patients {
            r4:BundleEntry entry = {'resource: patient};
            entries.push(entry);
        }
        return bundle.toJson();
    } else if message is hl7v23:ADT_A01 {
        r4:Patient patient = HL7V23_ADT_A01ToPatient(message);
        entries.push({'resource: patient});
        return bundle.toJson();
    } else if message is hl7v23:ADT_A04 {
        r4:Patient patient = HL7V23_ADT_A04ToPatient(message);
        entries.push({'resource: patient});
        return bundle.toJson();
    } else if message is hl7v23:ORU_R01 {
        r4:Patient[] patients = HL7V23_ORU_R01ToPatient(message);
        foreach r4:Patient patient in patients {
            r4:BundleEntry entry = {'resource: patient};
            entries.push(entry);
        }
        return bundle.toJson();
    } else {
        message.entries().forEach(function(anydata triggerEventField) {
            string key;
            anydata segment;
            [key, segment] = <[string, anydata]>triggerEventField;
            if segment is hl7:Segment {
                r4:BundleEntry[] bundleEntries = Generic_Segment_To_FHIR(segment.name, segment);
                foreach r4:BundleEntry entry in bundleEntries {
                    entries.push(entry);
                }
            }
        });
        if entries.length() > 0 {
            return bundle.toJson();
        }
        return getOperationOutcome("Unsupported message type.");
    }
}

