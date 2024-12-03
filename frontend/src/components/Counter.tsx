import React from "react";
import Counts from "./Counts";
import { useSelector, useDispatch } from "react-redux";
import { RootState } from "../store/store";
import { increment, decrement, reset } from "../store/counterSlice";
import { useSubmitCountMutation } from "../store/apiSlice";

const Counter: React.FC = () => {
  const count = useSelector((state: RootState) => state.counter.value);
  const dispatch = useDispatch();
  const [submitCount] = useSubmitCountMutation();

  const handleSubmit = async () => {
    try {
      await submitCount(count).unwrap(); // Submit the count to the backend
      console.log("Successfully submitted count:", count);

      dispatch(reset()); // Reset the counter after successful submission
    } catch (error) {
      console.error("Failed to submit count:", error);
    }
  };

  return (
    <div className="flex flex-col items-center p-4">
      <h1 className="text-2xl font-bold mb-4">Counter: {count}</h1>
      <div className="flex space-x-2">
        <button
          onClick={() => dispatch(increment())}
          className="px-4 py-2 bg-green-500 text-white rounded-md hover:bg-green-600"
        >
          Increment
        </button>
        <button
          onClick={() => dispatch(decrement())}
          className="px-4 py-2 bg-red-500 text-white rounded-md hover:bg-red-600"
        >
          Decrement
        </button>
        <button
          onClick={() => dispatch(reset())}
          className="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600"
        >
          Reset
        </button>
      </div>
      <div className="flex items-center justify-center my-4">
        <button
          onClick={handleSubmit}
          className="px-4 py-2 bg-pink-500 text-white rounded-md hover:bg-pink-600"
        >
          Submit
        </button>
      </div>
      <div className="flex flex-col items-center justify-center my-4">
        <h2 className="text-2xl font-bold">Counts:</h2>
        <Counts />
      </div>
    </div>
  );
};

export default Counter;
