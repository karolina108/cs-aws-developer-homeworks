import json
import os
import boto3

dynamodb = boto3.client('dynamodb')
table_name = os.environ['DYNAMODB_TABLE']
sqsclient = boto3.client('sqs')

def lambda_handler(event, context):

    print(event)

    user_counter = 0
    records = get_records(event)

    if len(records) > 0:
        for message in records:
            print('Processing message: {}'.format(message))

            user_details = get_user_details(message)
            print('Processing user: {}'.format(user_details))

            dynamodb_response = save_user_details(user_details)
            print('DynamoDB response: {}'.format(dynamodb_response))

            queue_name = get_queue_name(message)
            print('Queue name: '.format(queue_name))

            queue_url = get_queue_url(queue_name)
            print('Queue url: '.format(queue_url))

            receipt_handle = get_message_receipt_handle(message)
            print('Receipt handle: '.format(receipt_handle))

            queue_response = delete_message_from_queue(receipt_handle, queue_url)
            print('Queue response: '.format(queue_response))

            user_counter = user_counter + 1

    print('Processed {} user(s)'.format(user_counter))


def get_records(event):
    return event['Records']


def get_user_details(message):
    return message['body']


def save_user_details(body):
    user_details = json.loads(body)
    name = user_details['name']

    if name == '':
        name = 'Anonymous'

    response = dynamodb.put_item(
        TableName=table_name,
        Item={
            'email': {'S': user_details['email']},
            'name': {'S': name}
        }
    )
    print('Saved user: {}'.format(name))
    return response


def get_queue_name(message):
    return message['eventSourceARN'].split(":")[-1]


def get_queue_url(queue_name):
    response = sqsclient.get_queue_url(QueueName=queue_name)
    return response['QueueUrl']


def get_message_receipt_handle(message):
    return message['receiptHandle']


def delete_message_from_queue(receipt_handle, queue_url):

    response = sqsclient.delete_message(
        QueueUrl=queue_url,
        ReceiptHandle=receipt_handle
    )
    return response
