import json
import os
import boto3

dynamodb = boto3.client('dynamodb')
table_name = os.environ['DYNAMODB_TABLE']

def lambda_handler(event, context):

    try:
        email = event['email']

        if email == '':
            raise Exception('No email provided')
    except:
        return display_error_message()

    else:
        save_message(event)
        return display_message(event)
    finally:
        log_message(event)


def log_message(data):
    print('User registered with email: ' + data['email'] + ' and name: ' + data['name'])

def save_message(data):

    name = data['name']

    if name == '':
        name = 'Anonymous'

    dynamodb.put_item(
        TableName = table_name,
        Item = {
            'email': {'S': data['email']},
            'name': {'S': name}
        }
    )

def display_message(data):

    name = data['name']

    if name == '':
        name = 'Anonymous'

    additionalMessage = 'We will send you all the details to your e-mail address.'

    return 'Hello '+ name + '! Thanks for registration. ' + additionalMessage + ' See you at the Party!'

def display_error_message():
    return 'Please provide a valid e-mail address'