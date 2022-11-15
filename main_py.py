import json

GET_RAW_PATH = "/birthDate"

def lambda_handler(event, context):
    print(event)
    if event['rawPath'] == GET_RAW_PATH:
        print('Received birthDate request')
        personId = event['queryStringParameters']['date']
        print("with param date =" + date)
        return { "Birth date:": + date, }