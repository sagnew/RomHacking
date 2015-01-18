import time

import json
import requests
import arrow

old_count = 0
while True:
    previous_text = ''
    with open('input.txt', 'r') as input_text:
        previous_text = input_text.read()
    with open('input.txt', 'w') as input_content, open('output.txt', 'r') as output_content:
        count = int(output_content.read())
        if count > old_count:
            fact = requests.get('http://bearcatfacts.info').text
            print fact
            input_content.write(fact)
            old_count = count
        else:
            input_content.write(previous_text)
    delivery_json = str(requests.get('https://api.postmates.com/v1/customers/cus_JyoSxlnoD8cMyk/deliveries', auth=('3d0dd751-ab19-460d-95a0-436e279ca72b', '')).text)
    delivery = json.loads(delivery_json)
    with open('time.txt', 'w') as time_file:
        now = arrow.utcnow()
        eta = arrow.get(delivery['data'][0]['pickup_eta'])
        diff = eta - now
        print eta.humanize()
        print now
        print diff.seconds
        time_file.write(str(diff.seconds))
    time.sleep(1)
