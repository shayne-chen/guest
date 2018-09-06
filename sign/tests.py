from django.test import TestCase
from sign.models import Event, Guest

# Create your tests here.
class ModelTest(TestCase):

	def setUp(self):
		Event.objects.create(id=1, name="Macbook event", status=True, limit=100, address='Beijing', start_time='2018-09-06 01:00:00')
		Guest.objects.create(id=1, event_id=1, realname='Mark', phone='18310610896', email='mark@163.com', sign=False)

	def test_event_models(self):
		result = Event.objects.get(name="Macbook event")
		self.assertEqual(result.address, "Beijing")
		self.assertTrue(result.status)

	def test_guest_models(self):
		result = Guest.objects.get(phone='18310610896')
		self.assertEqual(result.realname, 'Mark')
		self.assertFalse(result.sign)