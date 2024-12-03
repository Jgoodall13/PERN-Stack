import React from "react";
import { useGetCountsQuery } from "../store/apiSlice";

const Counts: React.FC = () => {
  const { data: counts = [], isLoading, isError } = useGetCountsQuery();

  if (isLoading) {
    return <div>Loading counts...</div>;
  }

  if (isError) {
    return <div>Error loading counts.</div>;
  }

  return (
    <ul>
      {counts.length === 0 ? (
        <li>No counts available.</li>
      ) : (
        counts.map(({ id, count }) => <li key={id}>Count: {count}</li>)
      )}
    </ul>
  );
};

export default Counts;
