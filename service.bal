import ballerina/http;
import wso2healthcare/healthcare.hl7;
import ballerina/log;
import ballerina/regex;

hl7:HL7Parser parser = new ();

# A service representing a network-accessible API
# bound to port `9090`.
service / on new http:Listener(9090) {

    # service function to transform a v2 message to fhir
    # + return - transformed message as a json
    resource function post v2tofhir/transform(http:RequestContext ctx, http:Request request) returns http:Response|error {
        // extract the payload from the request
        string textPayload = check request.getTextPayload();
        string preprocessedPayload = regex:replaceAll(textPayload, "\n", "\r");
        http:Response response = new;

        byte[] hL7WirePayload = hl7:createHL7WirePayload(preprocessedPayload.toBytes());
        hl7:Message|hl7:HL7Error parsedMessage = parser.parse(hL7WirePayload);
        if parsedMessage is hl7:Message {
            // transform the message to fhir
            json transformToFHIRResult = check transformToFHIR(parsedMessage);
            log:printInfo("Transformed FHIR message: " + transformToFHIRResult.toString());
            response.setJsonPayload(transformToFHIRResult);
            response.statusCode = http:STATUS_OK;
            return response;
        } else {
            log:printError("Error occurred while parsing HL7 message.", parsedMessage);
            response.setJsonPayload(getOperationOutcome(parsedMessage.message()));
            response.statusCode = http:STATUS_INTERNAL_SERVER_ERROR;
            return response;
        }
    }
}
