import { Document, Types } from 'mongoose';
import { LocationModel } from '../models/location';
import { UserModel } from '../models/user';

async function createLocation(city: string, province: string, country: string, user: Document): Promise<Document> {
    try {
        const location: Document = await findLocation(city, province, country);
        user.set('location', location.get('_id'));
        return user.save();
    } catch (error) {
        const newLocation = new LocationModel({ city, province, country });
        return newLocation
            .save()
            .then((doc: Document) => {
                user.set('location', doc.get('_id'));
                return user.save();
            })
            .catch((error: Error) => {
                throw error;
            });
    }
}

async function deleteLocation(locationId: string): Promise<boolean> {
    if (!locationId) {
        return true;
    }
    const usersAtLocation: Document[] | null = await UserModel.find({ location: Types.ObjectId(locationId) });
    if (usersAtLocation.length === 1) {
        await LocationModel.deleteOne({ _id: Types.ObjectId(locationId) });
        return true;
    }
    return false;
}

async function findLocation(city: string, province: string, country: string): Promise<Document> {
    const location: Document | null = await LocationModel.findOne({ city, province, country });
    if (!location) {
        throw new Error('Location could not be found.');
    }
    return location;
}

export { createLocation, deleteLocation, findLocation };
