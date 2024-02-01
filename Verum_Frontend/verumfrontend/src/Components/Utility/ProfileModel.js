import { ViewIcon } from "@chakra-ui/icons";
import axios from 'axios';
import {
  Modal,
  ModalOverlay,
  ModalContent,
  ModalHeader,
  ModalFooter,
  ModalBody,
  ModalCloseButton,
  Button,
  useDisclosure,
  IconButton,
  FormLabel,
  Input,
  FormControl,
  useOptionalPart,

} from "@chakra-ui/react";
import { useState, useEffect } from "react";

const ProfileModal = ({ children }) => {
  const { isOpen, onOpen, onClose } = useDisclosure();
  const [User, setUser] = useState([]);
  const [userName, setuserName] = useState([User.userName])
  const [CurrentPassword, setCurrentPassword] = useState("")
  const [NewPassword, setNewPassword] = useState("")

  const isSaveDisabled = !CurrentPassword || !NewPassword || !userName;

  const fetchUser = async () => {
    const email = localStorage.getItem('email');
    const res = await axios.post('https://localhost:7226/Auth/GetUser', { email });
    console.log('res', res);
    if (res.status == 200) {
      setUser(res.data);
      setuserName(User.userName);
    }
  }

  useEffect(() => {
   
      fetchUser();
   
  }, [isOpen])

  const UpdateUserProfile = async () => {
    const UserLogin = localStorage.getItem('email');
    const UpdateResponse = await axios.put('https://localhost:7226/Auth/PassEdit', { userName, UserLogin , CurrentPassword , NewPassword });

    onClose(); // Close the modal after saving
    setCurrentPassword("");
    setNewPassword("");
  };


  return (
    <>
      {children ? (
        <span onClick={onOpen}>{children}</span>
      ) : (
        <IconButton d={{ base: "flex" }} icon={<ViewIcon />} onClick={onOpen} />
      )}
      <Modal
        isOpen={isOpen}
        onClose={onClose}
      >
        <ModalOverlay />
        <ModalContent>
          <ModalHeader>Update Profile</ModalHeader>
          <ModalCloseButton />
          <ModalBody pb={6}>
            <FormControl>
              <FormLabel>Email</FormLabel>
              <Input placeholder='Email' disabled={true} value={User.userLogin} />
            </FormControl>

            <FormControl mt={4}>
              <FormLabel>User Name</FormLabel>
              <Input placeholder='User Name' value={userName}
                onChange={(e) => {
                  setuserName(e.target.value);
                }} />
            </FormControl>
            <FormControl mt={4}>
              <FormLabel>Current Password</FormLabel>
              <Input placeholder='Current Password' type="password" onChange={(e) => {
                setCurrentPassword(e.target.value);
              }} />
            </FormControl>
            <FormControl mt={4}>
              <FormLabel>New Password</FormLabel>
              <Input placeholder='New Password' type="password" onChange={(e) => {
                setNewPassword(e.target.value);
              }} />
            </FormControl>
          </ModalBody>

          <ModalFooter>
            <Button colorScheme='blue' mr={3} onClick={UpdateUserProfile} isDisabled={isSaveDisabled} >
              Save
            </Button>
            <Button onClick={onClose}>Cancel</Button>
          </ModalFooter>
        </ModalContent>
      </Modal>
    </>
  );
};

export default ProfileModal;