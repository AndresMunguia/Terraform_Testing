exports.handler = async (event) => {
    const name = event.queryStringParameters?.name || "random person";
    const body = { success: true, message: 'Hello ' + name + " from Lambda!" };
    const response = {
        statusCode: 200,
        body: JSON.stringify(body),
    };
    return response;
};
