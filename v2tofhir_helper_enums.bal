import wso2healthcare/healthcare.fhir.r4;
import wso2healthcare/healthcare.hl7v24;
import wso2healthcare/healthcare.hl7v23;
import wso2healthcare/healthcare.hl7v25;

public function V2ToFHIR_GetHumanNameUse(hl7v23:ID|hl7v24:ID|hl7v25:ID id) returns r4:HumanNameUse => id is r4:HumanNameUse ? id: "usual";

public function V2ToFHIR_GetAddressType(hl7v23:ID|hl7v24:ID|hl7v25:ID id) returns r4:AddressType => id is r4:AddressType ? id: "postal";

public function V2ToFHIR_GetAddressUse(hl7v23:ID|hl7v24:ID|hl7v25:ID id) returns r4:AddressUse => id is r4:AddressUse ? id: "home";

public function V2ToFHIR_GetContactPointUse(hl7v23:ID|hl7v24:ID|hl7v25:ID id) returns r4:ContactPointUse => id is r4:ContactPointUse ? id: "home";

public function V2ToFHIR_GetContactPointSystem(hl7v23:ID|hl7v24:ID|hl7v25:ID id) returns r4:ContactPointSystem => id is r4:ContactPointSystem ? id: "phone";
