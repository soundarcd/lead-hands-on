import axios from "axios";
import React from "react";


export default function App() {
  const [post, setPost] = React.useState(null);

  React.useEffect(() => {
    axios.get(`${process.env.REACT_APP_API_BASE_URL}/ping`).then((response) => {
      setPost(response.data);
    });
  }, []);

  if (!post) return null;

  return (
    <div>
      <h1>Pong!</h1>
      <p>{post}</p>
    </div>
  );
}
