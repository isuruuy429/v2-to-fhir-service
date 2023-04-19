import wso2healthcare/healthcare.fhir.r4;

public function V2ToFHIR_GetStringExtension(string[] itemList) returns r4:StringExtension[] {
    r4:StringExtension[] stringExtensions = [];

    foreach string item in itemList {
        if item != "" {
            stringExtensions.push({
                url: item,
                valueString: item
            });
        }
    }

    return stringExtensions;
}

public function V2ToFHIR_GetIntegerExtension(string[] itemList) returns r4:IntegerExtension[]|error {
    r4:IntegerExtension[] integerExtensions = [];

    foreach string item in itemList {
        if item != "-1" && item !="" {
            integerExtensions.push({
                url: item.toString(),
                valueInteger: check int:fromHexString(item)
            });
        }
    }

    return integerExtensions;
}
