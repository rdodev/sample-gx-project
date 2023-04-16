import great_expectations as gx
from great_expectations.checkpoint import SimpleCheckpoint

# Set up
context = gx.get_context()


validator = context.sources.pandas_default.read_csv(
    filepath_or_buffer="https://raw.githubusercontent.com/great-expectations/gx_tutorials/main/data/yellow_tripdata_sample_2019-01.csv"
)

# Create Expectations
validator.expect_column_values_to_not_be_null("pickup_datetime")
validator.expect_column_values_to_be_between(
    column="congestion_surcharge", min_value=0, max_value=1000
)

# Validate data
checkpoint = SimpleCheckpoint( 
    f"NY-Taxi-Data",
    context,
    validator=validator,
)
checkpoint_result = checkpoint.run()

print("Howdy!")




