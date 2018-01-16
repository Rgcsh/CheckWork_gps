import requests
import time

lon = 121.249606
lat = 31.216294
# entity_name = request.values.get('name')
entity_name = '5_qq_com'
search_info = {'ak': '6K5WcKZXU3auhy8K15cWmUvWipvYVCMD',
               'service_id': 136114,
               'coord_type_input': 'wgs84',
               'entity_name': entity_name,
               'latitude': lat,
               'longitude': lon,
               'loc_time': int(time.time())
               }
URL = 'http://yingyan.baidu.com/api/v3'
r = requests.post(URL + '/track/addpoint', data=search_info)
print r.text