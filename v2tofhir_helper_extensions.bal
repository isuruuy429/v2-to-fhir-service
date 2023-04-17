import wso2healthcare/healthcare.fhir.r4;
// import wso2healthcare/healthcare.hl7v23;

public function V2ToFHIR_GetStringExtension(string[] itemList) returns r4:StringExtension[] {
    r4:StringExtension[] stringExtensions = [];

    foreach var item in itemList {
        stringExtensions.push({
            url: item,
            valueString: item
        });
    }

    return stringExtensions;
}

public function V2ToFHIR_GetIntegerExtension(int[] itemList) returns r4:IntegerExtension[] {
    r4:IntegerExtension[] integerExtensions = [];

    foreach var item in itemList {
        integerExtensions.push({
            url: item.toString(),
            valueInteger: item
        });
    }

    return integerExtensions;
}