exports.handler = async (event) => {
    const date = event.queryStringParameters?.date || "NA";
    const body = { success: true, message: 'Birth date is: ' + date };
    const response = {
        statusCode: 200,
        body: JSON.stringify(body),
    };
    return response;
};
