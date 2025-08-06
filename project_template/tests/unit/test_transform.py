import unittest

from etl.transform import transform_data


class TestTransformData(unittest.TestCase):
    def test_transform_data(self):
        # Sample input data
        input_data = [
            {"id": 1, "value": 10},
            {"id": 2, "value": 20},
            {"id": 3, "value": 30},
        ]

        # Expected output data after transformation
        expected_output = [
            {"id": 1, "value": 20},  # Example transformation: value * 2
            {"id": 2, "value": 40},
            {"id": 3, "value": 60},
        ]

        # Call the transform_data function
        output_data = transform_data(input_data)

        # Assert that the output matches the expected output
        self.assertEqual(output_data, expected_output)


if __name__ == "__main__":
    unittest.main()
