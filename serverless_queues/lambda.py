import json
import os
import boto3

sqsclient = boto3.client('sqs')
queue_name = os.environ['QUEUE_NAME']

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

def save_message(data):

    print(queue_name)

    response = sqsclient.get_queue_url(QueueName=queue_name)
    queue_url = response['QueueUrl']
    print(queue_url)

    response = sqsclient.send_message_batch(
        QueueUrl=queue_url,
        Entries=[
            {
                'Id' : '1',
                'MessageBody': json.dumps(data)
            },
        ])
    return response

def log_message(data):
    print('User registered with email: ' + data['email'] + ' and name: ' + data['name'])


def display_message(data):

    name = data['name']

    if name == '':
        name = 'Anonymous'

    additionalMessage = 'We will send you all the details to your e-mail address.'

    return 'Hello '+ name + '! Thanks for registration. ' + additionalMessage + ' See you at the Party!'

def display_error_message():
    return 'Please provide a valid e-mail address'