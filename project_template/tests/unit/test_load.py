import unittest

from etl.load import load_data


class TestLoadData(unittest.TestCase):
    def test_load_data_success(self):
        # Sample data to load
        data = {"id": 1, "name": "Test"}
        destination = "test_destination"

        # Assuming load_data returns True on success
        result = load_data(data, destination)
        self.assertTrue(result)

    def test_load_data_failure(self):
        # Sample data with an invalid destination
        data = {"id": 1, "name": "Test"}
        destination = None  # Invalid destination

        # Assuming load_data raises an exception on failure
        with self.assertRaises(ValueError):
            load_data(data, destination)


if __name__ == "__main__":
    unittest.main()
