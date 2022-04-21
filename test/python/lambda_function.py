import boto3
s3 = boto3.resource('s3') 
client = boto3.client('s3')

def lambda_handler(event, context):
    bucket = event['detail']["requestParameters"]["bucketName"]
    response = client.put_public_access_block(
        Bucket=bucket,
        PublicAccessBlockConfiguration={
            'BlockPublicAcls': True,
            'IgnorePublicAcls': True,
            'BlockPublicPolicy': True,
            'RestrictPublicBuckets': True
        }
    )