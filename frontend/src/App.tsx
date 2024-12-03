import React from "react";
import Counter from "./components/Counter";

const App: React.FC = () => {
  return (
    <div className="flex justify-center items-center min-h-screen bg-gray-100">
      <Counter />
    </div>
  );
};

export default App;
