import React, { useState } from "react";
import axios from 'axios';
import {
  Card,
  CardBody,
  CardHeader,
  useToast,
  Button,
  Heading,
  Container,
  Input,
  InputGroup,
  FormLabel,
  FormControl,
  VStack,
} from "@chakra-ui/react";
import { useNavigate } from "react-router-dom";

export default function Login() {
  const [email, setemail] = useState([]);
  const [password, setpassword] = useState([]);
  const [loading, setloading] = useState(false);
  const toast = useToast();
  const navigate = useNavigate();

  const LoginHandler = async () => {
    setloading(true);
    if (!email || !password) {
      toast({
        title: "Fill all Details",
        status: "warning",
        duration: 3000,
        isClosable: true,
        position: "bottom",
      });
      setloading(false);
    } else{
      try {
        const login = await axios.post('https://localhost:7226/Auth/LoginAdmin', { email, password });
        if (login.data == 10) {
      localStorage.setItem('email', email);
      navigate('/home');
      toast({
        title: "User Login SuccessFull ",
        status: "success",
        duration: 3000,
        isClosable: true,
        position: "bottom",
      });
    }
    else {
      toast({
        title: "Invalid user Credentails",
        status: "error",
        duration: 3000,
        isClosable: true,
        position: "bottom",
      });
      setloading(false);
    }

        
      } catch (error) {
        toast({
          title: "Something Went Wrong",
          status: "warning",
          duration: 3000,
          isClosable: true,
          position: "bottom",
        });
        setloading(false);
        
      }

    }
    
  };
  return (
    <Container marginTop={150}>
      <Card>
        <CardHeader>
          <Heading size="md" style={{ textAlign: "center" }}>
            {" "}
            Admin Login Verum
          </Heading>
        </CardHeader>
        <CardBody>
          <VStack spacing="5px">
            <FormControl isRequired id="Email">
              <FormLabel> Email</FormLabel>
              <Input
                placeholder="Enter Your Email"
                onChange={(e) => {
                  setemail(e.target.value);
                }}
              />
            </FormControl>
            <FormControl isRequired id="Password">
              <FormLabel> Password</FormLabel>

              <InputGroup>
                <Input
                  type="password"
                  placeholder="Enter Your Password"
                  onChange={(e) => {
                    setpassword(e.target.value);
                  }}
                />
              </InputGroup>
            </FormControl>

            <Button
              mt={2}
              colorScheme="blue"
              width="100%"
              style={{ marginTop: 15 }}
              onClick={LoginHandler}
              isLoading={loading}
            >
              Login
            </Button>
          </VStack>
        </CardBody>
      </Card>
    </Container>
  );
}
