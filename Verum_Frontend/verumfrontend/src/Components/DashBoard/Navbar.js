import React, { useState, useEffect } from 'react'
import axios from 'axios';
import { Avatar, Box, Button, Menu, MenuButton, MenuItem, MenuList, Text } from '@chakra-ui/react';
import { ChevronDownIcon } from "@chakra-ui/icons";
import ProfileModel from '../Utility/ProfileModel';
import { useNavigate } from 'react-router-dom';



export default function Navbar() {

    const navigate = useNavigate();
    const Logouthandler = () => {
        navigate('/');
    }
    return (
        <Box p='5px 5px 5px 5px' style={{ display: "flex", justifyContent: "space-between" }}>
            <Text>

            </Text>
            <Text fontSize="3xl" fontFamily="Work sans">
                Verum Admin Panel
            </Text>
            <div>
                <Menu>

                    <MenuButton as={Button} bg="white" rightIcon={<ChevronDownIcon />}>
                        <Avatar
                            size="sm"
                            cursor="pointer"
                            name={localStorage.getItem('email')}
                        />

                    </MenuButton>
                    <MenuList pl={2}>
                        <ProfileModel>
                            <MenuItem>Update Profile</MenuItem>
                        </ProfileModel>
                        <MenuItem onClick={Logouthandler}>Logout</MenuItem>
                    </MenuList>
                </Menu>
            </div>


        </Box>
    )
}
