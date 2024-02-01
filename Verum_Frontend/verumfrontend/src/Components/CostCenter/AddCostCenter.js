import axios from "axios";
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
    FormLabel,
    Input,
    FormControl,
    useToast,

} from "@chakra-ui/react";
import { useEffect, useState } from "react";

const AddCostCenter = ({ triggercost }) => {
    const { isOpen, onOpen, onClose } = useDisclosure();
    const [CostCenterCode, setCostCenterCode] = useState([]);
    const [TitleCostCenter, setTitleCostCenter] = useState([]);
    const [TitleEnglishCostCenter, setTitleEnglishCostCenter] = useState([]);
    const [FlagProfitCenter, setFlagProfitCenter] = useState(false);
    const [DescriptionCostCenter, setDescriptionCostCenter] = useState([]);
    const toast = useToast();

    const clearState = () => {
        setCostCenterCode([])
        setTitleCostCenter([])
        setTitleEnglishCostCenter([])
        setFlagProfitCenter(false)
        setDescriptionCostCenter([])
    }
    const TriggerModal = () => {
        onOpen();
    }
    useEffect(() => {
        TriggerModal();
    }, [triggercost]);

    const AddCostCenter = async () => {
        const response = await axios.post('https://localhost:7226/Tables/AddCostCenter', {
            CostCenterCode, TitleCostCenter, TitleEnglishCostCenter,
            FlagProfitCenter, DescriptionCostCenter
        });
        if (response.status == 200) {
            toast({
                title: response.data,
                status: "success",
                duration: 3000,
                isClosable: true,
                position: "bottom",
            });
            onClose();
            clearState();
        } else {
            toast({
                title: response.data,
                status: "error",
                duration: 3000,
                isClosable: true,
                position: "bottom",
            });
        }

    }

    return (
        <>
            <Modal
                isOpen={isOpen}
                onClose={onClose}
            >
                <ModalOverlay />
                <ModalContent>
                    <ModalHeader>Add Cost Center </ModalHeader>
                    <ModalCloseButton />
                    <ModalBody pb={6}>
                        <FormControl>
                            <FormLabel>SCHLUSSEL</FormLabel>
                            <Input placeholder='SCHLUSSEL' value={CostCenterCode} onChange={(e) => setCostCenterCode(e.target.value)} />
                        </FormControl>

                        <FormControl mt={4}>
                            <FormLabel>TITEL</FormLabel>
                            <Input placeholder='TITEL' value={TitleCostCenter} onChange={(e) => setTitleCostCenter(e.target.value)} />
                        </FormControl>
                        <FormControl mt={4}>
                            <FormLabel>TITEL ENGLISCH</FormLabel>
                            <Input placeholder='TITEL ENGLISCH' value={TitleEnglishCostCenter} onChange={(e) => setTitleEnglishCostCenter(e.target.value)} />
                        </FormControl>
                        <FormControl mt={4}>
                            <FormLabel>KOSTENTRAGER</FormLabel>
                            <input type='radio' checked={FlagProfitCenter} placeholder='KOSTENTRAGER' onChange={() => setFlagProfitCenter(!FlagProfitCenter)} />
                        </FormControl>
                        <FormControl mt={4}>
                            <FormLabel>BESCHREIBUNG</FormLabel>
                            <Input type="paragraph" placeholder='BESCHREIBUNG' value={DescriptionCostCenter} onChange={(e) => setDescriptionCostCenter(e.target.value)} />
                        </FormControl>
                    </ModalBody>

                    <ModalFooter>
                        {
                            <Button colorScheme='blue' mr={3} onClick={() => AddCostCenter()}>
                                Add
                            </Button>
                        }

                        <Button onClick={onClose}>Cancel</Button>
                    </ModalFooter>
                </ModalContent>
            </Modal>
        </>
    );
};

export default AddCostCenter;
