import json
import os
import boto3

dynamodb = boto3.client('dynamodb')
table_name = os.environ['DYNAMODB_TABLE']
sqsclient = boto3.client('sqs')
queue_name = os.environ['QUEUE_NAME']


def lambda_handler(event, context):

    user_counter = 0
    queue_url = get_queue_url(queue_name)
    response = sqsclient.receive_message(QueueUrl=queue_url, MaxNumberOfMessages=10)
    messages = response.get('Messages')

    if messages is not None:
        for message in messages:

            user_details = get_user_details(message)
            save_user_details(user_details)

            receipt_handle = get_message_receipt_handle(message)
            delete_message_from_queue(receipt_handle, queue_url)

            user_counter = user_counter + 1

    print('Processed {} user(s)'.format(user_counter))


def get_user_details(message):
    return json.loads(message['Body'])


def save_user_details(user_details):

    name = user_details['name']

    if name == '':
        name = 'Anonymous'

    dynamodb.put_item(
        TableName=table_name,
        Item={
            'email': {'S': user_details['email']},
            'name': {'S': name}
        }
    )


def get_queue_url(queue_name):

    response = sqsclient.get_queue_url(QueueName=queue_name)
    return response['QueueUrl']


def get_message_receipt_handle(message):
    return message['ReceiptHandle']


def delete_message_from_queue(receipt_handle, queue_url):

    sqsclient.delete_message(
        QueueUrl=queue_url,
        ReceiptHandle=receipt_handle
    )