import time
import requests

old_count = 0
while True:
    with open('input.txt', 'w') as input_content, open('output.txt', 'r') as output_content:
        count = int(output_content.read())
        if count > old_count:
            fact = requests.get('http://bearcatfacts.info').text
            print fact
            input_content.write(fact)
            old_count = count
        time.sleep(1)
