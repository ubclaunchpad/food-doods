import { Document } from 'mongoose';
import { LocationModel } from '../models/location';

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

async function findLocation(city: string, province: string, country: string): Promise<Document> {
    const location: Document | null = await LocationModel.findOne({ city, province, country });
    if (!location) {
        throw new Error('Location could not be found.');
    }
    return location;
}

export { createLocation, findLocation };
