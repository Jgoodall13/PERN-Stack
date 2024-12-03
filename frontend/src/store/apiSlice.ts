import { createApi, fetchBaseQuery } from "@reduxjs/toolkit/query/react";

export const apiSlice = createApi({
  reducerPath: "api",
  baseQuery: fetchBaseQuery({ baseUrl: "http://localhost:4000" }),
  tagTypes: ["Counts"], // Define a tag for the counts data
  endpoints: (builder) => ({
    getCounts: builder.query<{ id: number; count: number }[], void>({
      query: () => "/counts",
      providesTags: ["Counts"], // Associate this query with the "Counts" tag
    }),
    submitCount: builder.mutation<void, number>({
      query: (count) => ({
        url: "/counts",
        method: "POST",
        body: { count },
      }),
      invalidatesTags: ["Counts"], // Invalidate the "Counts" tag after mutation
    }),
  }),
});

export const { useGetCountsQuery, useSubmitCountMutation } = apiSlice;
