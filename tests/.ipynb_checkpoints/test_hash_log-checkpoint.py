from wells.hash_log import hash_log

image1 = open('tests/images/1.tiff', 'rb').read()
image2 = open('tests/images/2.tiff', 'rb').read()

def test_returns_string():
    """
    GIVEN an image
    WHEN its hashed
    THEN it returns a string
    """
    hash_value = hash_log(image1)
    assert isinstance(hash_value, str)

def test_consistent_hash():
    """
    GIVEN an image
    WHEN its hashed twice
    THEN the same hash is returned
    """
    hash_value_1 = hash_log(image1)
    hash_value_2 = hash_log(image1)
    assert hash_value_1 == hash_value_2

def test_unique_hash():
    """
    GIVEN two different images
    WHEN they are both hashed
    THEN different hashes are returned
    """
    hash_value_1 = hash_log(image1)
    hash_value_2 = hash_log(image2)
    assert hash_value_1 != hash_value_2
