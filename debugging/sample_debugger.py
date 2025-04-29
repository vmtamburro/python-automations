import debugpy

# Start the debugger and listen on a specific port
debugpy.listen(("localhost", 5678))
print("Waiting for debugger to attach...")  # Optional: Helps you know when to attach
debugpy.wait_for_client()  # Pause execution until the debugger is attached